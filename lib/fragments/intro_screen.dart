import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../routes/pageRoute.dart';
import '../service/user_service.dart';
import '../utility/validatation.dart';
import '../service/register_login_service.dart';
import '../fragments/home.dart';
import '../model/user.dart';

class IntroPage extends StatefulWidget {
  static const String routeName = '/IntroPage';

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool _isLoggedIn = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _checkIsLoggedIn();
  }

  void _checkIsLoggedIn() async {
    User user = await User.readSession();
    if (user.id != 0) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  final mobileTxtField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoggedIn ? Home() : loginForm(context),
    );
  }

  Form loginForm(BuildContext context) {
    return new Form(
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
              _loginORregister(context);
              Center(child: CircularProgressIndicator());
            }
          },
          child: Text('Next'),
        ),
      ]),
    );
  }

  void _loginORregister(BuildContext context) async {
    bool isUserExist =
        await UserService().isUserExist(mobileTxtField.text, context);
    if (isUserExist == false) {
      Navigator.pushNamed(context, PageRoutes.registration,
          arguments: {"mobile": mobileTxtField.text});
    } else {
      String signatureCode = await SmsAutoFill().getAppSignature;
      var sentOtp = await RegisterLoginService()
          .sendOtp(mobileTxtField.text, signatureCode, context);
      Navigator.pushNamed(context, PageRoutes.loginByOtp,
          arguments: {"otp": sentOtp, "mobile": mobileTxtField.text});
    }
    print(mobileTxtField);
  }
}
