import 'package:flutter/material.dart';
import '../service/parcel_service.dart';
import '../service/register_login_service.dart';
import 'new_pickup_point.dart';
import '../utility/helper.dart';
import '../widget/TextInput.dart';
import 'package:awesome_select/awesome_select.dart';

class RegistrationPage extends StatefulWidget {
  static const String routeName = '/registrationPage';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  int productTypeId = 0;
  List<S2Choice<int>> productTypes = [];

  void initState() {
    super.initState();
    setProductList();
  }

  void setProductList() async {
    var _futureOfList = ParcelService().getParcelTypes();
    List list = await _futureOfList;
    for (var i = 0; i < list.length; i++) {
      setState(() {
        productTypes
            .add(S2Choice<int>(value: list[i]['id'], title: list[i]['name']));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    String mobile = '';
    // ignore: unnecessary_null_comparison
    if (arguments != null) {
      mobile = arguments['mobile'];
    }
    return Scaffold(
      body: new Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
            child: TextInput(
              inputController: nameController,
              label: 'আপনার নাম',
              icon: Icons.account_box_sharp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
            child: TextInput(
              inputController: businessNameController,
              label: 'আপনার বিজনেস এর নাম',
              icon: Icons.business_center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
            child: SmartSelect<int>.single(
              modalFilter: true,
              modalFilterAuto: true,
              tileBuilder: (context, state) => S2Tile<dynamic>(
                //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
                title: const Text(
                  'প্রোডাক্ট এর ধরন',
                ),
                value: state.selected?.toWidget() ?? Container(),
                leading: Icon(Icons.list_outlined),
                onTap: state.showModal,
              ),
              title: 'প্রোডাক্ট এর ধরন',
              placeholder: 'সিলেক্ট করুন',
              choiceItems: productTypes,
              onChange: (state) => setState(() => productTypeId = state.value!),
              selectedValue: productTypeId,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _register(context, mobile);
              }
            },
            child: Text('রেজিস্ট্রার'),
          )
        ]),
      ),
    );
  }

  void _register(BuildContext context, String mobile) async {
    var response = await RegisterLoginService().register(
        mobile,
        nameController.text,
        businessNameController.text,
        productTypeId,
        context);
    if (response['status'] == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewPickupPoint()));
    } else {
      Helper.errorSnackbar(context, response['message'].toString());
      //print(response);
    }
  }
}
