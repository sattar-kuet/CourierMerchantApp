import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  static const String routeName = '/registrationPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Registration"),
        ),
        
        body: Center(child: Text("This is Registration page")));
  }
}
