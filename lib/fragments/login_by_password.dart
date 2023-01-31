import 'package:flutter/material.dart';
import '../service/register_login_service.dart';
import 'bank_screen.dart';
import '../fragments/new_pickup_point.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../utility/helper.dart';
import 'home.dart';

class LoginByPasswordPage extends StatefulWidget {
  static const String routeName = '/LoginByPasswordPage';

  const LoginByPasswordPage({Key? key}) : super(key: key);

  @override
  State<LoginByPasswordPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginByPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final passwordTxtField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    String mobile = '';
    String login = '';
    // ignore: unnecessary_null_comparison
    if (arguments != null) {
      mobile = arguments['mobile'];
      login = arguments['login'];
    }
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 70,
            margin: const EdgeInsets.only(bottom: 50),
            child: const Image(image: AssetImage('assets/logo.png')),
          ),
          Text('আপনার মোবাইল নাম্বার: $mobile'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
            child: TextFormField(
              controller: passwordTxtField,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                labelText: 'পাসওয়ার্ড দিন',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _login(login, passwordTxtField.text);
                const Center(child: CircularProgressIndicator());
              }
            },
            child: const Text('Next'),
          ),
        ]),
      ),
    );
  }

  Future<void> _login(String login, String password) async {
    // var response = await RegisterLoginService().login(login, password, context);
    var response = await RegisterLoginService().readCookiesFromAPI(login, password, context);
    // print(response);
    // if (response['status'] == 1) {
    //   int nextStep =
    //       // ignore: use_build_context_synchronously
    //       await RegisterLoginService().nextStepToFinishProfile(context);
    //   switch (nextStep) {
    //     case 1:
    //       // ignore: use_build_context_synchronously
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const NewPickupPoint(),
    //           ));
    //       break;
    //     case 2:
    //       // ignore: use_build_context_synchronously
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const BankScreen(),
    //           ));
    //       break;
    //     default:
    //       // ignore: use_build_context_synchronously
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const Home(),
    //           ));
    //       break;
    //   }
    // } else {
    //   // ignore: use_build_context_synchronously
    //   // Helper.errorSnackbar(context, response.message.toString());

    //   print(response);
    // }
  }
}
