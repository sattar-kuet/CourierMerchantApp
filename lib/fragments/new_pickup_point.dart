import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/service.dart';
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
  int areaId = 0;
  void initState() {
    super.initState();
    updateDistrictList();

    updateAreaList(districtId);

    Service().getPickupAddress(context).then((response) {
      setState(() {
        nameController.text = response['title'];
        addressController.text = response['street'];
        districtId = response['district'];
        areaId = response['upazilla'];
      });
    });
  }

  updateDistrictList() async {
    var _futureOfList = Service().getDistrictList();
    List list = await _futureOfList;
    for (var i = 0; i < list.length; i++) {
      setState(() {
        districts
            .add(S2Choice<int>(value: list[i]['id'], title: list[i]['name']));
      });
    }
  }

  updateAreaList(int? value) async {
    var _futureOfList = await Service().getAreaList(districtId, context);
    List list = await _futureOfList;
    List<S2Choice<int>> areaList = [];
    setState(() {
      list.forEach((element) {
        areas.add(S2Choice<int>(value: element['id'], title: element['name']));
      });
    });
  }

  setDistrictList() async {
    var _futureOfList = Service().getDistrictList();
    List list = await _futureOfList;
    for (var i = 0; i < list.length; i++) {
      setState(() {
        districts
            .add(S2Choice<int>(value: list[i]['id'], title: list[i]['name']));
      });
    }
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
                            areaId = 0;
                            updateAreaList(state.value).then((value) {
                              setState(() {});
                            });
                          });
                        },
                        selectedValue: districtId,
                      ),
                    ),
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
                            setState(() => areaId = state.value!),
                        selectedValue: areaId,
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
    Service().addPickupPoint(nameController.text, districtId, areaId,
        addressController.text, context);
  }
}
