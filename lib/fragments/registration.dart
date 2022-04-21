import 'package:flutter/material.dart';

import '../widget/TextInput.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegistrationPage extends StatefulWidget {
  static const String routeName = '/registrationPage';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameInput = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController productTypeId = TextEditingController();
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
            child: TextInput(
              inputController: nameInput,
              label: 'আপনার নাম',
              icon: Icons.account_box_sharp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
            child: TextInput(
              inputController: nameInput,
              label: 'আপনার বিজনেস এর নাম',
              icon: Icons.business_center,
            ),
          ),
          
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _register(context);
              }
            },
            child: Text('Next'),
          )
        ]),
      ),
    );
  }

  void _register(BuildContext context) {}
}
