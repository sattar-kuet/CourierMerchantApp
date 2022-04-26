import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/service.dart';
import 'package:flutter_app/fragments/new_pickup_point.dart';
import 'package:flutter_app/widget/TextInput.dart';

class EditPickupPoint extends StatefulWidget {
  static const String routeName = '/editPickupPointPage';
  const EditPickupPoint({Key? key, required this.title, required this.district,required this.area, required this.streetAddress}) : super(key: key);
  final String title;
  final String district;
  final String area;
  final String streetAddress;

  @override
  State<EditPickupPoint> createState() => _EditPickupPointState();
}

class _EditPickupPointState extends State<EditPickupPoint> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var districtList = Service().getDistrictList().then((value) => print(value));
  int districId = 0;
  int areaId = 0;
  
  // Boolean for shoing the form as map will only be shown when user press this button
  bool showform = false;
  List<S2Choice<int>> districts = [
    // S2Choice<int>(value: 1, title: 'Dhaka'),
    // S2Choice<int>(value: 2, title: 'Cumilla'),
    // S2Choice<int>(value: 3, title: 'Rajshahi')
  ];
  List<S2Choice<int>> areas = [];
  @override
  void initState() {
    super.initState();
    returnDistrictValues();
    setState(() {
      nameController.text = widget.title;
      addressController.text = widget.streetAddress;
    });
    // Service().getPickupAddress().then((value) {
    //   print(value);
    //   setState(() {
    //     userPickupPoint = value;
    //   });
    // });
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

  updateAreaList() async {
    var _futureOfList = Service().getAreaList(districId);
    List list = await _futureOfList;
    for (var i = 0; i < list.length; i++) {
      setState(() {
        areas.add(S2Choice<int>(value: list[i]['id'], title: list[i]['name']));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit pickup point'),
      ),
      body: SingleChildScrollView(
        child: new Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
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
                      placeholder: "${widget.district}",
                      choiceItems: districts,
                      onChange: (state) {
                        setState(() => districId = state.value!);
                        updateAreaList();
                      },
                      selectedValue: districId,
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
                        placeholder: '${widget.area}',
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
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: () async{
                if (showform == false) {
                  setState(() {
                    showform = true;
                  });
                } else {
                  if (_formKey.currentState!.validate()) {
                   await Service().addPickupPoint(nameController.text, districId,
                        areaId, addressController.text, context);
                        setState(() {
                          showform = false;
                        });
                  }
                }
              },
              child: Text('Edit Pickup Point'),
            )
          ]),
        ),
      ),
      
    );
  }

  
}