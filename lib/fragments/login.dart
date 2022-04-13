import 'package:flutter/material.dart';
import '../common/menu_drawer.dart';
import '../routes/pageRoute.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileTxtField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              margin: EdgeInsets.only(bottom: 50),
              child: Image(image: AssetImage('assets/logo.png')),
              ),
              Text('মোবাইল নাম্বার দিয়ে খুব সহজেই রেজিস্ট্রেশন করুন।',),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
          child: TextField(
            controller: mobileTxtField,
            keyboardType: TextInputType.number,
             decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                labelText: 'আপনার মোবাইল নাম্বারটি দিন',
              ),
          ),
          ),
          ElevatedButton(onPressed: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.registration), child: Text('Next'),)
         
        ]),
        
       );
  }
  

}
