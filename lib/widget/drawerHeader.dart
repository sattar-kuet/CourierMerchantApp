import 'package:flutter/material.dart';

Widget drawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage('assets/logo.png'),
      )),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Welcome to Flutter",
                style: TextStyle(
                    color: Color.fromARGB(255, 10, 10, 10),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}
