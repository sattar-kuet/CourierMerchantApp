import 'package:flutter/material.dart';

Widget drawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.amber,
      ),
      child: Stack(children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.png'),
            ),
          ),
        ),
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
