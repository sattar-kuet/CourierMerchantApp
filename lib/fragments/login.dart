import 'package:flutter/material.dart';
import '../common/menu_drawer.dart';
import '../routes/pageRoute.dart';
import '../utility/validatation.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                   loginORregister();
              }
            },    
            child: Text('Next'),
          )
        ]),
      ),
    );
  }

  void loginORregister(){
    print(mobileTxtField);
    Navigator.pushReplacementNamed(context, PageRoutes.registration);
  }
  
}
