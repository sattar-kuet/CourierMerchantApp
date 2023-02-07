import 'package:flutter/material.dart';
import '../routes/pageRoute.dart';
import '../service/register_login_service.dart';
import 'bank_screen.dart';
import '../fragments/new_pickup_point.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../utility/helper.dart';
import 'home.dart';

class OtpValidationPage extends StatefulWidget {
  static const String routeName = '/OtpValidationPage';

  const OtpValidationPage({Key? key}) : super(key: key);

  @override
  State<OtpValidationPage> createState() => _OtpValidationPageState();
}

class _OtpValidationPageState extends State<OtpValidationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController optInutField = TextEditingController();
  final mobileTxtField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    String password = '';
    String login = '';
    String phone = '';
    bool userExist = false;
    // ignore: unnecessary_null_comparison
    if (arguments != null) {
      password = arguments['password'];
      login = arguments['login'];
      phone = arguments['phone'];
      userExist = arguments['userExist'];
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
          Text('Sent Otp is: $password'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 70),
            child: PinFieldAutoFill(
              codeLength: 6,
              controller: optInutField,
              autoFocus: true,
              cursor: Cursor(
                enabled: true,
                color: Colors.black,
                width: 1,
                height: 30,
              ),
              onCodeChanged: (enteredCode) {
                if (enteredCode?.length == 6) {
                  if (enteredCode.toString() == password.toString()) {
                    if (userExist) {
                      _login(login, password);
                    } else {
                      Navigator.pushNamed(context, PageRoutes.registration,
                          arguments: {
                            "password": password,
                            "login": login,
                            "phone": phone,
                          });
                    }
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

  Future<void> _login(String login, String password) async {
    var response = await RegisterLoginService().login(login, password, context);
    if (response['status'] == true) {
      print('login sucess');
      int nextStep = 3;
      //ignore: use_build_context_synchronously
      // await RegisterLoginService().nextStepToFinishProfile(context);
      switch (nextStep) {
        case 1:
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewPickupPoint(),
              ));
          break;
        case 2:
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BankScreen(),
              ));
          break;
        default:
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ));
          break;
      }
    } else {
      // ignore: use_build_context_synchronously
      Helper.errorSnackbar(context, 'Unable to login user');
      // Helper.errorSnackbar(context, response.message.toString());
      optInutField.clear();
      //print(response);
    }
  }
}
