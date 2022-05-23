import 'package:flutter/material.dart';
import 'package:flutter_app/data/service.dart';
import 'bank_screen.dart';
import 'package:flutter_app/fragments/new_pickup_point.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../utility/helper.dart';
import 'home.dart';

class LoginbyotpPage extends StatefulWidget {
  static const String routeName = '/loginbyotpPage';

  @override
  State<LoginbyotpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginbyotpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController optInutField = TextEditingController();
  final mobileTxtField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    String sentOtp = '';
    String mobile = '';
    // ignore: unnecessary_null_comparison
    if (arguments != null) {
      sentOtp = arguments['otp'];
      mobile = arguments['mobile'];
    }
    return Scaffold(
      body: new Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 70,
            margin: EdgeInsets.only(bottom: 50),
            child: Image(image: AssetImage('assets/logo.png')),
          ),
          Text('Sent Otp is: $sentOtp'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 70),
            child: PinFieldAutoFill(
              codeLength: 4,
              controller: optInutField,
              autoFocus: true,
              cursor: Cursor(
                enabled: true,
                color: Colors.black,
                width: 1,
                height: 30,
              ),
              onCodeChanged: (enteredCode) {
                if (enteredCode?.length == 4) {
                  if (enteredCode.toString() == sentOtp.toString()) {
                    _login(mobile);
                  } else {
                    optInutField.clear();
                    Helper.errorSnackbar(
                        context, 'Wrong CODE. Please try again.');
                  }
                }
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _login(String mobile) async {
    var response = await Service().login(mobile, optInutField.text, context);
    if (response['status'] == 1) {
      int nextStep = await Service().nextStepToFinishProfile(context);
      switch (nextStep) {
        case 1:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPickupPoint(),
              ));
          break;
        case 2:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BankScreen(),
              ));
          break;
        default:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
          break;
      }
    } else {
      Helper.errorSnackbar(context, response.message.toString());
      optInutField.clear();
      //print(response);
    }
  }
}
