import 'package:flutter/material.dart';
import '../common/menu_drawer.dart';

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
        appBar: AppBar(
          title: Text("Login"),
        ),
        drawer: MenuDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(padding: const EdgeInsets.all(20.0),
          child: TextField(
             decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Mobile Number',
              ),
          ),
          ),
         
        ]),
        // body: Center(
        //   child: Padding(
        //   padding: const EdgeInsets.all(20.0),
        //   child: TextFormField(
        //       decoration: const InputDecoration(
        //         border: UnderlineInputBorder(),
        //         labelText: 'Enter Mobile Number',
        //       ),
        //     ),
        // ),
        
       );
  }
}
