import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginbyotpPage extends StatefulWidget {
  static const String routeName = '/loginbyotpPage';

  @override
  State<LoginbyotpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginbyotpPage> {
  final _formKey = GlobalKey<FormState>();

  final mobileTxtField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    // ignore: unnecessary_null_comparison
     String otp = '';
    if(arguments !=null){
      otp = arguments['otp'];
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
          Text('Sent Otp is: $otp'),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: PinFieldAutoFill(
              codeLength: 4,
              onCodeChanged: (code) {
                print(code);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                login();
              }
            },
            child: Text('Login'),
          )
        ]),
      ),
    );
  }

  void login() {}
}
