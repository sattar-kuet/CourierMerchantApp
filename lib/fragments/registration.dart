import 'package:flutter/material.dart';
import '../service/parcel_service.dart';
import '../service/register_login_service.dart';
import 'home.dart';
import 'new_pickup_point.dart';
import '../utility/helper.dart';
import '../widget/TextInput.dart';

class RegistrationPage extends StatefulWidget {
  static const String routeName = '/registrationPage';

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    String mobile = '';
    String password = '';
    // ignore: unnecessary_null_comparison
    if (arguments != null) {
      mobile = arguments['phone'];
      password = arguments['password'];
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
              inputController: emailController,
              label: 'আপনার ই-মেইল',
              icon: Icons.email_sharp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
            child: TextInput(
              inputController: businessNameController,
              label: 'আপনার ব্যবসা / ব্র্যান্ড এর নাম',
              icon: Icons.business_sharp,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _register(context, mobile, password);
              }
            },
            child: const Text('রেজিস্ট্রার'),
          )
        ]),
      ),
    );
  }

  void _register(BuildContext context, String mobile, String password) async {
    var response = await RegisterLoginService().register(
        nameController.text,
        emailController.text,
        mobile,
        businessNameController.text,
        password,
        context);
    if (response['status'] == 200) {
      // ignore: use_build_context_synchronously
      await RegisterLoginService()
          .login(emailController.text, password, context);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    } else {
      // ignore: use_build_context_synchronously
      print(response);
      Helper.errorSnackbar(context, response['error'].toString());
      //print(response);
    }
  }
}
