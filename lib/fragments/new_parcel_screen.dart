import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/form_components/form_button.dart';
import '../data/service.dart';
import '../form_components/textInput.dart';
import '../model/pickup_point.dart';
import '../utility/validatation.dart';

class NewParcelPage extends StatefulWidget {
  static const String routeName = '/NewParcelPage';

  @override
  State<NewParcelPage> createState() => _NewParcelPageState();
}

class _NewParcelPageState extends State<NewParcelPage> {
  final _formKey = GlobalKey<FormState>();
  bool showCustomerInfo = false;
  final mobileTxtField = TextEditingController();
  final customerNameController = TextEditingController();
  int fromUpazillaId = 0;
  int districId = 0;
  int upazillaId = 0;
  int parcelTypeId = 0;
  int deliverySpeed = 0;
  double deliveryChange = 0;
  double codChange = 0;
  double totalChange = 0;
  final upazillaIdController = TextEditingController();
  final addressController = TextEditingController();
  final parcelValue = TextEditingController();
  final cashCollection = TextEditingController();
  final parcelWeight = TextEditingController();
  final clientReference = TextEditingController();
  final note = TextEditingController();

  bool districtListLoadingDone = false;
  bool upazillaListLoadingDone = false;
  bool deliverySpeedListLoadingDone = false;

  List<S2Choice<int>> districts = [];
  List<S2Choice<int>> upazillas = [];
  List<S2Choice<int>> pacerlTypes = [];
  List<S2Choice<int>> deliverySpeeds = [];
  @override
  void initState() {
    super.initState();
    PickupPoint.readSession().then((StoredPickupPoint) {
      setState(() {
        fromUpazillaId = StoredPickupPoint.upazillaId;
      });
    });
    //parcelWeight.addListener(updateDeliveryCharge);
    setDistrictList();
    setpacerlTypeList();
  }

  setDistrictList() {
    Service().getDistrictList().then((districtList) {
      List<S2Choice<int>> formattedDistrictList = [];
      for (var i = 0; i < districtList.length; i++) {
        formattedDistrictList.add(S2Choice<int>(
            value: districtList[i]['id'], title: districtList[i]['name']));
      }
      setState(() {
        districts = formattedDistrictList;
        districtListLoadingDone = true;
      });
    });
  }

  setpacerlTypeList() {
    Service().getParcelTypes().then((pacerlTypeList) {
      List<S2Choice<int>> formattedpacerlTypeList = [];
      for (var i = 0; i < pacerlTypeList.length; i++) {
        formattedpacerlTypeList.add(S2Choice<int>(
            value: pacerlTypeList[i]['id'], title: pacerlTypeList[i]['name']));
      }
      setState(() {
        pacerlTypes = formattedpacerlTypeList;
      });
    });
  }

  updateUpazillaList(districId) {
    Service().getUpazillaList(districId, context).then((upazillaList) {
      List<S2Choice<int>> formattedupazillaList = [];
      for (var i = 0; i < upazillaList.length; i++) {
        formattedupazillaList.add(S2Choice<int>(
            value: upazillaList[i]['id'], title: upazillaList[i]['name']));
      }
      setState(() {
        upazillas = formattedupazillaList;
        upazillaListLoadingDone = true;
      });
    });
  }

  updateDeliverySpeedList() {
    Service()
        .getDeliverySpeedList(fromUpazillaId, upazillaId, parcelTypeId, context)
        .then((deliverySpeedList) {
      List<S2Choice<int>> formattedDeliverySpeedList = [];
      for (var i = 0; i < deliverySpeedList.length; i++) {
        formattedDeliverySpeedList.add(S2Choice<int>(
            value: deliverySpeedList[i]['value'],
            title: deliverySpeedList[i]['label']));
      }
      setState(() {
        deliverySpeeds = formattedDeliverySpeedList;
        deliverySpeedListLoadingDone = true;
      });
    });
  }

  updateDeliveryCharge() {
    if (fromUpazillaId > 0 &&
        upazillaId > 0 &&
        parcelWeight.text.isNotEmpty &&
        deliverySpeed > 0) {
      var data = {};
      data['fromUpazillaId'] = fromUpazillaId;
      data['toUpazillaId'] = upazillaId;
      data['parcelWeight'] = double.parse(parcelWeight.text);
      data['parcelTypeId'] = parcelTypeId;
      data['deliverySpeed'] = deliverySpeed;
      Service().getDeliveryCharge(data, context).then((responseValue) {
        setState(() {
          deliveryChange = responseValue;
          totalChange = deliveryChange + codChange;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryChargeAppBar(),
      body: SingleChildScrollView(
        child: ParcelForm(context),
      ),
      bottomSheet: BottomSheet(
        builder: (context) {
          return FormButton(text: 'Save');
        },
        onClosing: () {},
      ),
    );
  }

  AppBar DeliveryChargeAppBar() {
    return AppBar(
      title: Container(
        padding: EdgeInsets.all(20.0),
        child: Table(
          children: [
            TableRow(children: [
              Text(
                'ডেলিভারি চার্জ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'COD চার্জ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'মোট',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ]),
            TableRow(children: [
              Text(
                '$deliveryChange ৳',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '$codChange ৳',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '$totalChange ৳',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  Form ParcelForm(BuildContext context) {
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
          inputIcon: Icon(Icons.supervised_user_circle_sharp),
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
            onChange: (state) {
              setState(() {
                upazillaId = state.value!;
                upazillaListLoadingDone = true;
              });
              // updateDeliverySpeedList();
            },
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
              parcelTypeId = state.value!;
            });
            updateDeliverySpeedList();
            updateDeliveryCharge();
          },
          selectedValue: parcelTypeId,
        ),
      ),
      if (fromUpazillaId > 0 &&
          upazillaId > 0 &&
          parcelTypeId > 0 &&
          deliverySpeedListLoadingDone)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
          child: SmartSelect<int>.single(
            modalFilter: true,
            modalFilterAuto: true,
            tileBuilder: (context, state) => S2Tile<dynamic>(
              //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
              title: const Text(
                'ডেলিভারি স্পিড',
              ),
              value: state.selected?.toWidget() ?? Container(),
              leading: Icon(Icons.speed_sharp),
              onTap: state.showModal,
            ),
            title: 'ডেলিভারি স্পিড',
            placeholder: 'সিলেক্ট করুন',
            choiceItems: deliverySpeeds,
            onChange: (state) => setState(() => deliverySpeed = state.value!),
            selectedValue: deliverySpeed,
          ),
        ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
        child: textInput(
          label: 'পার্সের ওজন',
          inputController: parcelWeight,
          onChangeEvent: () {
            updateDeliveryCharge();
          },
          inputIcon: Icon(Icons.monitor_weight_sharp),
          helperText: "যেমনঃ 100 গ্রাম হলে 0.1",
          suffixHelpText:
              Padding(padding: EdgeInsets.all(15), child: Text('KG ')),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
        child: textInput(
          label: 'পন্যের বিক্রয় মূল্য',
          inputController: parcelValue,
          inputIcon: Icon(Icons.verified_sharp),
          suffixHelpText:
              Padding(padding: EdgeInsets.all(15), child: Text('৳')),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
        child: textInput(
          label: 'ক্যাশ কালেশন',
          inputController: cashCollection,
          inputIcon: Icon(Icons.collections_sharp),
          suffixHelpText:
              Padding(padding: EdgeInsets.all(15), child: Text('৳')),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
        child: textInput(
          label: 'নোট (যদি থাকে)',
          inputController: note,
          inputIcon: Icon(Icons.edit_note),
        ),
      ),
      Container(
        height: 40,
        width: double.infinity,
      ),
    ];
  }

  void _saveParcel(BuildContext context) {}
}
