import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../routes/pageRoute.dart';
import '../utility/validatation.dart';
import '../data/http_helper.dart';

class IntroPage extends StatefulWidget {
  static const String routeName = '/IntroPage';

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
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
            'মোবাইল নাম্বার দিয়ে খুব সহজেই রেজিস্ট্রেশন করুন।',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
            child: TextFormField(
              controller: mobileTxtField,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                labelText: 'আপনার মোবাইল নাম্বারটি দিন',
              ),
              validator: (value) {
                return Validation.validdateMobile(value);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                loginORregister(context);
              }
            },
            child: Text('Next'),
          )
        ]),
      ),
    );
  }

<<<<<<< HEAD
  void loginORregister(BuildContext context) async {
    HttpHelper httpHelper = HttpHelper();
    dynamic res = httpHelper.isUserExist(mobileTxtField.text);
    print(res);
    // ignore: unrelated_type_equality_checks
    if (httpHelper.isUserExist(mobileTxtField.text) == false) {
      Navigator.pushReplacementNamed(context, PageRoutes.registration);
    } else {
      final signatureCode = await SmsAutoFill().getAppSignature;
      String otp = httpHelper
          .sendOtp(mobileTxtField.text, signatureCode.toString())
          .toString();
      print(otp);
      Navigator.pushReplacementNamed(context, PageRoutes.loginByOtp);
    }
=======
  void loginORregister(BuildContext context) {
    HttpHelper httpHelper = HttpHelper();
    dynamic res = httpHelper.isUserExist(mobileTxtField.text);
    print(res);

    httpHelper.isUserExist(mobileTxtField.text).then((value) {
      if (value.user_exist == false) {
        Navigator.pushReplacementNamed(context, PageRoutes.registration);
      } else {
        String otp = httpHelper.sendOtp(mobileTxtField.text).toString();
        print(otp);
        Navigator.pushReplacementNamed(context, PageRoutes.loginByOtp);
      }
    });

    // if (httpHelper.isUserExist(mobileTxtField.text) == false) {
    //   Navigator.pushReplacementNamed(context, PageRoutes.registration);
    // } else {
    //   String otp = httpHelper.sendOtp(mobileTxtField.text).toString();
    //   print(otp);
    //   Navigator.pushReplacementNamed(context, PageRoutes.loginByOtp);
    // }
>>>>>>> 9cce93da58b5ec0c828223deb7b833cf179a16aa
    // print(mobileTxtField);
  }
}
