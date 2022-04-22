  import 'package:flutter/material.dart';
  Container logo() {
    return Container(
          height: 70,
          margin: EdgeInsets.only(bottom: 20),
          child: Image(image: AssetImage('assets/logo.png')),
        );
  }