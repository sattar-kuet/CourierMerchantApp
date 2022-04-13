import 'package:flutter/material.dart';
import '../common/menu_drawer.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/loginPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        drawer: MenuDrawer(),
        body: Center(child: Text("This is login page")));
  }
}
