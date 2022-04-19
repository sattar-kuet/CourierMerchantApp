import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        
        body: Center(child: Text("This is Home")));
  }
}
