import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

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
          Text(
            'OTP দিন',
          ),
          
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 80,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
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
