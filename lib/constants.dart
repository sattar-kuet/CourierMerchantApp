import 'package:flutter/material.dart';

const String BASE_URL = 'https://portal.gofirstbd.com/api/v2';

class Color {
  static const BUTTON_BG = '#dda';
  static const BRAND = '#aad';
}

class BankAccountType {
  static const MOBILE = 1;
  static const NORMAL = 0;
}

class NeumorphismDecoration {
  final BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(6.0),
    color: Colors.grey.shade50,
    shape: BoxShape.rectangle,
    boxShadow: [
      BoxShadow(
          color: Colors.grey.shade300,
          spreadRadius: 0.0,
          blurRadius: 1.5,
          offset: Offset(3.0, 3.0)),
      BoxShadow(
          color: Colors.grey.shade400,
          spreadRadius: 0.0,
          blurRadius: 1.5 / 2.0,
          offset: Offset(3.0, 3.0)),
      BoxShadow(
          color: Colors.white,
          spreadRadius: 2.0,
          blurRadius: 1.5,
          offset: Offset(-3.0, -3.0)),
      BoxShadow(
          color: Colors.white,
          spreadRadius: 2.0,
          blurRadius: 1.5 / 2,
          offset: Offset(-3.0, -3.0)),
    ],
  );
}
