import 'package:flutter/material.dart';

import '../utility/validatation.dart';

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

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.inputController,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final TextEditingController inputController;
  final String label;
  final icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        prefixIcon: Icon(icon),
        labelText: label,
      ),
      validator: (value) {
        return Validation.required(value);
      },
    );
  }
}
