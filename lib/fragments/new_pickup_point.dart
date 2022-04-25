import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/service.dart';
import '../common/bottom_navigation.dart';
import '../common/floating_button.dart';
import '../common/logo.dart';
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
        title: Text('Add new pickup point'),
      ),
      body: SingleChildScrollView(
        child: new Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              decoration: boxDecoration,
              margin: const EdgeInsets.all(10),
              child: Text("Add Pickup Point", style: TextStyle(fontSize: 20)),
              
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
              child: TextInput(
                inputController: nameController,
                label: 'পিকআপ পয়েন্টের নাম',
                icon: Icons.edit,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
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
                  setState(() => districId = state.value!);
                  updateAreaList();
                },
                selectedValue: districId,
              ),
            ),
            if(districId!=0)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
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
                onChange: (state) => setState(() => areaId = state.value!),
                selectedValue: areaId,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                 Service().addPickupPoint(nameController.text, districId, areaId, addressController.text);
                }
              },
              child: Text('Add Pickup Point'),
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: floating,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addPickupPoint(BuildContext context, districtId, areaId) {

  }
  final BoxDecoration boxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(6.0),
  color: Colors.grey.shade50,
  // shape: BoxShape.rectangle,
  boxShadow: [
    BoxShadow(
        color: Colors.grey.shade300,
        spreadRadius: 1.5,
        blurRadius: 1.5,
        offset: Offset(3.0, 3.0)),
    BoxShadow(
        color: Colors.grey.shade400,
        spreadRadius: 2,
        blurRadius: 2 / 2.0,
        offset: Offset(3.0, 3.0)
        ),
    BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 2,
        offset: Offset(0, -3.0)),
    BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 2 / 2,
        offset: Offset(-3.0, -3.0)),
  ],);
}
