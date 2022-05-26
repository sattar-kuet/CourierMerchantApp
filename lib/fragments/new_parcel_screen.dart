import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import '../data/service.dart';
import '../form_components/textInput.dart';
import '../utility/validatation.dart';

class NewParcelPage extends StatefulWidget {
  static const String routeName = '/NewParcelPage';

  @override
  State<NewParcelPage> createState() => _NewParcelPageState();
}

class _NewParcelPageState extends State<NewParcelPage> {
  final _formKey = GlobalKey<FormState>();
  bool showCustomerInfo = false;
  @override
  void initState() {
    super.initState();
    setDistrictList();
    setpacerlTypeList();
  }

  final mobileTxtField = TextEditingController();
  final customerNameController = TextEditingController();
  int districId = 0;
  int areaId = 0;
  int productTypeId = 0;
  final upazillaIdController = TextEditingController();
  final addressController = TextEditingController();
  final parcelTypeId = TextEditingController();
  final deliverySpeed = TextEditingController();
  final parcelValue = TextEditingController();
  final cashCollection = TextEditingController();
  final productWeight = TextEditingController();
  final clientReference = TextEditingController();
  final note = TextEditingController();

  List<S2Choice<int>> districts = [];
  List<S2Choice<int>> areas = [];
  List<S2Choice<int>> pacerlTypes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: introForm(context),
      ),
    );
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

  setpacerlTypeList() async {
    var _futureOfList = Service().getParcelTypes();
    List list = await _futureOfList;
    for (var i = 0; i < list.length; i++) {
      setState(() {
        pacerlTypes
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

  Form introForm(BuildContext context) {
    return new Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
          child: TextFormField(
            controller: mobileTxtField,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
              labelText: 'কাস্টমার মোবাইল নাম্বারটি দিন',
              suffixIcon: UnconstrainedBox(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_right_sharp,
                    color: Colors.blue,
                  ),
                  iconSize: 48,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        showCustomerInfo = true;
                      });
                      Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            validator: (value) {
              return Validation.validdateMobile(value);
            },
          ),
        ),
        ..._customerForm(context),
        ..._parcelForm(context),
      ]),
    );
  }

  List<Widget> _customerForm(BuildContext context) {
    //Service service = Service(); TODO: get Customer detail by mobile
    if (!showCustomerInfo) {
      return [];
    }
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
        child: textInput(
          label: "কাস্টমার এর নাম",
          inputController: customerNameController,
          inputIcon: Icon(Icons.verified_user),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
        child: SmartSelect<int>.single(
          modalFilter: true,
          modalFilterAuto: true,
          tileBuilder: (context, state) => S2Tile<dynamic>(
            //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
            title: const Text(
              'জেলা',
            ),
            value: state.selected?.toWidget() ?? Container(),
            leading: Icon(Icons.map_sharp),
            onTap: state.showModal,
          ),
          title: 'জেলা',
          placeholder: 'সিলেক্ট করুন',
          choiceItems: districts,
          onChange: (state) {
            setState(() {
              districId = state.value!;
              updateAreaList(state.value).then((value) {
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
          child: SmartSelect<int>.single(
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) => S2Tile<dynamic>(
              //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
              title: const Text(
                'এলাকা',
              ),
              value: state.selected?.toWidget() ?? Container(),
              leading: Icon(Icons.map_outlined),
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
        child: textInput(
          label: 'বিস্তারিত ঠিকানা',
          inputController: addressController,
          inputIcon: Icon(Icons.house_sharp),
        ),
      ),
    ];
  }

  List<Widget> _parcelForm(BuildContext context) {
    //Service service = Service(); TODO: get Customer detail by mobile
    if (!showCustomerInfo) {
      return [];
    }
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
        child: SmartSelect<int>.single(
          modalFilter: true,
          modalFilterAuto: true,
          tileBuilder: (context, state) => S2Tile<dynamic>(
            //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
            title: const Text(
              'পার্সেল এর ধরন',
            ),
            value: state.selected?.toWidget() ?? Container(),
            leading: Icon(Icons.list),
            onTap: state.showModal,
          ),
          title: 'পার্সেল এর ধরন',
          placeholder: 'সিলেক্ট করুন',
          choiceItems: pacerlTypes,
          onChange: (state) {
            setState(() {
              districId = state.value!;
              updateAreaList(state.value).then((value) {
                setState(() {});
              });
            });
            // print(state.value);
            // setState(() => districId = state.value!);
            // updateAreaList();
            // print("V VALUE HAS BEEN CHANGED to $districId");
          },
          selectedValue: productTypeId,
        ),
      ),
      if (districId != 0)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
          child: SmartSelect<int>.single(
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) => S2Tile<dynamic>(
              //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
              title: const Text(
                'এলাকা',
              ),
              value: state.selected?.toWidget() ?? Container(),
              leading: Icon(Icons.map_outlined),
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
        child: textInput(
          label: 'বিস্তারিত ঠিকানা',
          inputController: addressController,
          inputIcon: Icon(Icons.house_sharp),
        ),
      ),
    ];
  }
}
