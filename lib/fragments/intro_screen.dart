import 'package:flutter/material.dart';
import 'package:flutter_app/utility/helper.dart';
import 'package:sms_autofill/sms_autofill.dart';

// import 'package:sms_autofill/sms_autofill.dart';
import '../routes/pageRoute.dart';
import '../service/register_login_service.dart';
import '../service/user_service.dart';
import '../utility/validatation.dart';

// import '../service/register_login_service.dart';
import '../fragments/home.dart';

class IntroPage extends StatefulWidget {
  static const String routeName = '/IntroPage';

  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool _isLoggedIn = false;
  String newPassword = '';
  String login = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _checkIsLoggedIn();
  }

  void _checkIsLoggedIn() async {
    final userId = Helper.getUserId();
    if (userId != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  final mobileTxtField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoggedIn ? const Home() : loginForm(context),
    );
  }

  Form loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 70,
          margin: const EdgeInsets.only(bottom: 50),
          child: const Image(image: AssetImage('assets/logo.png')),
        ),
        const Text(
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
              const Center(child: CircularProgressIndicator());
            }
          },
          child: const Text('Next'),
        ),
      ]),
    );
  }

  void _loginORregister(BuildContext context) async {
    dynamic isUserExist =
        await UserService().isUserExist(mobileTxtField.text, context);
    //debugPrint(isUserExist);
    if (isUserExist['status'] == false) {
      debugPrint('registration');
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, PageRoutes.registration,
          arguments: {"mobile": mobileTxtField.text});
    } else {
      debugPrint('login');
      /*
      #################################################
      Login by OTP is disabled
      #################################################
      */
      String signatureCode = await SmsAutoFill().getAppSignature;
      setState(() {
        newPassword = isUserExist['new_password'];
        login = isUserExist['login'];
      });
      var message =
          "Your verification code  is : {newPassword} {signatureCode}";
      // ignore: use_build_context_synchronously
      await RegisterLoginService()
          .sendOtp(mobileTxtField.text, message, context);
      //ignore: use_build_context_synchronously
      Navigator.pushNamed(context, PageRoutes.loginByOtp,
          arguments: {"password": newPassword, "login": login});
      //ignore: use_build_context_synchronously
      // Navigator.pushNamed(context, PageRoutes.loginByPassword, arguments: {
      //   "mobile": mobileTxtField.text,
      //   "login": isUserExist['login'],
      // });
    }
  }
}
