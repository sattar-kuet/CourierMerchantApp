import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/service.dart';
import '../model/pickup_point.dart';
import '../common/bottom_navigation.dart';
import '../common/floating_button.dart';
import '../widget/TextInput.dart';

class NewPickupPoint extends StatefulWidget {
  static const String routeName = '/newPickupPointPage';
  const NewPickupPoint({Key? key}) : super(key: key);

  @override
  State<NewPickupPoint> createState() => _NewPickupPointState();
}

class _NewPickupPointState extends State<NewPickupPoint> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<S2Choice<int>> districts = [];
  List<S2Choice<int>> areas = [];

  int districtId = 0;
  int upazillaId = 0;
  bool districtListLoadingDone = false;
  bool areaListLoadingDone = false;
  bool existingDataLoded = false;
  void initState() {
    super.initState();
    PickupPoint.readSession().then((StoredPickupPoint) {
      setState(() {
        nameController.text = StoredPickupPoint.title;
        districtId = StoredPickupPoint.districtId;
        upazillaId = StoredPickupPoint.upazillaId;
        addressController.text = StoredPickupPoint.street;
        existingDataLoded = true;
      });
    });
    updateDistrictList();
    updateAreaList();
  }

  updateDistrictList() {
    Service().getDistrictList().then((_districtList) {
      for (var i = 0; i < _districtList.length; i++) {
        int id = _districtList[i]['id'];
        String name = _districtList[i]['name'];
        setState(() {
          districts.add(S2Choice<int>(value: id, title: name));
          districtListLoadingDone = true;
        });
      }
    });
  }

  updateAreaList() {
    Service().getAreaList(districtId, context).then((_areaList) {
      List<S2Choice<int>> areaList = [];
      for (var i = 0; i < _areaList.length; i++) {
        int id = _areaList[i]['id'];
        String name = _areaList[i]['name'];
        areaList.add(S2Choice<int>(value: id, title: name));
      }
      setState(() {
        areas = areaList;
        areaListLoadingDone = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new pickup point'),
      ),
      body: SingleChildScrollView(
        child: new Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Card For Showing user pickup addresse
            Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30.0),
                      child: TextInput(
                        inputController: nameController,
                        label: 'পিকআপ পয়েন্টের নাম',
                        icon: Icons.edit,
                      ),
                    ),
                    if (districtListLoadingDone && existingDataLoded)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30.0),
                        child: SmartSelect<int>.single(
                          modalFilter: true,
                          modalFilterAuto: true,
                          tileBuilder: (context, state) => S2Tile<dynamic>(
                            //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
                            title: const Text(
                              'জেলা',
                            ),
                            value: state.selected?.toWidget() ?? Container(),
                            leading: Icon(Icons.list_outlined),
                            onTap: state.showModal,
                          ),
                          title: 'জেলা',
                          placeholder: 'সিলেক্ট করুন',
                          choiceItems: districts,
                          onChange: (state) {
                            setState(() {
                              districtId = state.value!;
                              areaListLoadingDone = false;
                            });
                            updateAreaList();
                          },
                          selectedValue: districtId,
                        ),
                      ),
                    if (areaListLoadingDone && existingDataLoded)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30.0),
                        child: SmartSelect<int>.single(
                          modalFilter: true,
                          modalFilterAuto: true,
                          tileBuilder: (context, state) => S2Tile<dynamic>(
                            //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
                            title: const Text(
                              'এলাকা',
                            ),
                            value: state.selected?.toWidget() ?? Container(),
                            leading: Icon(Icons.list_outlined),
                            onTap: state.showModal,
                          ),
                          title: 'এলাকা',
                          placeholder: 'সিলেক্ট করুন',
                          choiceItems: areas,
                          onChange: (state) =>
                              setState(() => upazillaId = state.value!),
                          selectedValue: upazillaId,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30.0),
                      child: TextInput(
                          inputController: addressController,
                          label: 'বিস্তারিত ঠিকানা',
                          icon: Icons.map_outlined),
                    ),
                    Text(
                      'যেমনঃ ২য় তলা, বাসা নংঃ ১১৮, ব্লকঃ ডি, রোডঃ ০৫, মহানগর প্রজেক্ট, রামপুরা, ঢাকা',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _savePickupPoint(context);
                        }
                      },
                      child: Text('Save'),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: Padding(
          padding: EdgeInsets.only(
            top: 45,
          ),
          child: floating(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _savePickupPoint(BuildContext context) {
    Service().savePickupPoint(nameController.text, districtId, upazillaId,
        addressController.text, context);
  }
}
