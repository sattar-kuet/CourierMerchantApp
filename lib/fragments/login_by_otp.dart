import 'package:flutter/material.dart';
import 'package:flutter_app/data/service.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../routes/pageRoute.dart';

class LoginbyotpPage extends StatefulWidget {
  static const String routeName = '/loginbyotpPage';

  @override
  State<LoginbyotpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginbyotpPage> {
  final _formKey = GlobalKey<FormState>();
  String enteredOtp = '';
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
            padding: const EdgeInsets.all(5.0),
            child: PinFieldAutoFill(
              codeLength: 4,
              onCodeChanged: (enteredCode) {
                if (enteredCode.toString() == sentOtp.toString()) {
                  _login(mobile,enteredCode.toString());
                  setState(() {
                    enteredOtp = enteredCode.toString();
                  });
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _login(mobile,enteredOtp);
              }
            },
            child: Text('Login'),
          )
        ]),
      ),
    );
  }

  Future<void> _login(String mobile, String otp) async{
   var response =  await Service().login(mobile,otp);
   if(response['status'] == 1){
     Navigator.pushNamed(context, PageRoutes.home);
   }else{
     print(response);
   }
  }
}
