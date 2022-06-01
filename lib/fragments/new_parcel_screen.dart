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
  int upazillaId = 0;
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

  bool districtListLoadingDone = false;
  bool upazillaListLoadingDone = false;

  List<S2Choice<int>> districts = [];
  List<S2Choice<int>> upazillas = [];
  List<S2Choice<int>> pacerlTypes = [];
  setDistrictList()  {   
    Service().getDistrictList().then((districtList){
      List<S2Choice<int>> formattedDistrictList = [];
      for (var i = 0; i < districtList.length; i++) {
          formattedDistrictList
              .add(S2Choice<int>(value: districtList[i]['id'], title: districtList[i]['name']));
      }
      setState(() {
        districts = formattedDistrictList;
        districtListLoadingDone = true;
      });
    });
  }
  setpacerlTypeList()  {   
    Service().getParcelTypes().then((pacerlTypeList){
      List<S2Choice<int>> formattedpacerlTypeList = [];
      for (var i = 0; i < pacerlTypeList.length; i++) {
          formattedpacerlTypeList
              .add(S2Choice<int>(value: pacerlTypeList[i]['id'], title: pacerlTypeList[i]['name']));
      }
      setState(() {
        pacerlTypes = formattedpacerlTypeList;
      });
    });
  }
  updateUpazillaList(districId)  {   
    Service().getUpazillaList(districId, context).then((upazillaList){
      List<S2Choice<int>> formattedupazillaList = [];
      for (var i = 0; i < upazillaList.length; i++) {
          formattedupazillaList
              .add(S2Choice<int>(value: upazillaList[i]['id'], title: upazillaList[i]['name']));
      }
      setState(() {
        upazillas = formattedupazillaList;
        upazillaListLoadingDone = true;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
     bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
       appBar: AppBar(
        title: Text('Add new parcel'),
      ),
      body: SingleChildScrollView(
        child: introForm(context),
      ),
    );
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
              upazillaListLoadingDone = false;
            });
            updateUpazillaList(state.value);
            
          },
          selectedValue: districId,
        ),
      ),
      if (districId != 0 && upazillaListLoadingDone)
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
            choiceItems: upazillas,
            onChange: (state) => setState(() => upazillaId = state.value!),
            selectedValue: upazillaId,
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
              productTypeId = state.value!;
            });
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
            choiceItems: upazillas,
            onChange: (state) => setState(() => upazillaId = state.value!),
            selectedValue: upazillaId,
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
