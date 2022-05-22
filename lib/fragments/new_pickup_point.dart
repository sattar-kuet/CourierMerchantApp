import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/data/service.dart';
import 'package:flutter_app/fragments/edit_pickup_point.dart';
import 'package:flutter_app/widget/button.dart';
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
  var districtList = Service().getDistrictList().then((value) => print(value));
  int districId = 0;
  int areaId = 0;

  // Boolean for shoing the form as map will only be shown when user press this button
  bool showform = false;
  List<S2Choice<int>> districts = [];
  List<S2Choice<int>> areas = [];
  List userPickupPoint = [];

  @override
  void initState() {
    super.initState();
    returnDistrictValues();
    Service().getPickupAddress(context).then((pickupPoints) {
      setState(() {
        userPickupPoint = pickupPoints;
      });
    });
  }

  returnDistrictValues() async {
    var _futureOfList = Service().getDistrictList();
    List list = await _futureOfList;
    for (var i = 0; i < list.length; i++) {
      setState(() {
        districts
            .add(S2Choice<int>(value: list[i]['id'], title: list[i]['name']));
      });
    }
  }

  updateAreaList(districtid) async {
    var _futureOfList = await Service().getAreaList(districtid, context);
    List list = await _futureOfList;
    List<S2Choice<int>> areaList = [];
    setState(() {
      list.forEach((element) {
        areaList
            .add(S2Choice<int>(value: element['id'], title: element['name']));
      });
      print(areaList);
    });
    setState(() {
      areas = areaList;
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
            Container(
                padding: EdgeInsets.only(bottom: 10),
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.2,
                    maxHeight: MediaQuery.of(context).size.height * 0.25),
                width: MediaQuery.of(context).size.width,
                decoration: NeumorphismDecoration().boxDecoration,
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Scrollbar(
                  isAlwaysShown: false,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userPickupPoint.length == 0
                          ? 1
                          : userPickupPoint.length,
                      itemBuilder: (context, index) {
                        if (userPickupPoint.length == 0) {
                          return Column(
                            children: [
                              Text(
                                "No Pickup Point",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: ListTile(
                              title: Text(
                                  '${userPickupPoint[index]['title']}, ${userPickupPoint[index]['area_name']},${userPickupPoint[index]['district_name']}'),
                              subtitle:
                                  Text("${userPickupPoint[index]['street']}"),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Edit Button
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => EditPickupPoint(
                                                    title:
                                                        '${userPickupPoint[index]['title']}',
                                                    districtId:
                                                        userPickupPoint[index]
                                                            ['district'],
                                                    areaId:
                                                        userPickupPoint[index]
                                                            ['upazilla'],
                                                    streetAddress:
                                                        "${userPickupPoint[index]['street']}",
                                                    districtName:
                                                        '${userPickupPoint[index]['district_name']}',
                                                    areaName:
                                                        '${userPickupPoint[index]['area_name']}',
                                                    id: userPickupPoint[index]
                                                        ['id'],
                                                  )));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.indigo[900],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    padding: EdgeInsets.all(0),
                                    constraints: BoxConstraints(),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                )),
            CustumButtom(
                text: 'Add Pickup Point',
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (BuildContext context,
                            StateSetter setState /*You can rename this!*/) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                      tileBuilder: (context, state) =>
                                          S2Tile<dynamic>(
                                        //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
                                        title: const Text(
                                          'জেলা',
                                        ),
                                        value: state.selected?.toWidget() ??
                                            Container(),
                                        leading: Icon(Icons.list_outlined),
                                        onTap: state.showModal,
                                      ),
                                      title: 'জেলা',
                                      placeholder: 'সিলেক্ট করুন',
                                      choiceItems: districts,
                                      onChange: (state) {
                                        setState(() {
                                          districId = state.value!;
                                          updateAreaList(state.value)
                                              .then((value) {
                                            setState(() {});
                                          });
                                        });
                                        // print(state.value);
                                        // setState(() => districId = state.value!);
                                        // updateAreaList();
                                        // print("V VALUE HAS BEEN CHANGED to $districId");
                                      },
                                      selectedValue: districId,
                                    ),
                                  ),
                                  if (districId != 0)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 30.0),
                                      child: SmartSelect<int>.single(
                                        modalFilter: true,
                                        modalFilterAuto: true,
                                        tileBuilder: (context, state) =>
                                            S2Tile<dynamic>(
                                          //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
                                          title: const Text(
                                            'এলাকা',
                                          ),
                                          value: state.selected?.toWidget() ??
                                              Container(),
                                          leading: Icon(Icons.list_outlined),
                                          onTap: state.showModal,
                                        ),
                                        title: 'এলাকা',
                                        placeholder: 'সিলেক্ট করুন',
                                        choiceItems: areas,
                                        onChange: (state) => setState(
                                            () => areaId = state.value!),
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
                                  CustumButtom(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        Service()
                                            .addPickupPoint(
                                                nameController.text,
                                                districId,
                                                areaId,
                                                addressController.text,
                                                context)
                                            .then((updatedPickupPoint) {
                                          setState(() {
                                            userPickupPoint =
                                                updatedPickupPoint;
                                            nameController.clear();
                                            addressController.clear();
                                            districId = 0;
                                            areaId = 0;
                                            districts.clear();
                                            areas.clear();
                                          });
                                        });

                                        
                                      }
                                      print(userPickupPoint);
                                    },
                                    text: 'Add Pickup Point',
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                      });
                })
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
              child: floating)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
