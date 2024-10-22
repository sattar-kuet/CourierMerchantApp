import 'package:flutter/material.dart';

const String BASE_URL = 'https://app.somalicourier.com';
// ignore: constant_identifier_names
const String DATABASE = 'somalicourier';

class Color {
  static const BUTTON_BG =
      0xff123456; // where 123456 is your hex color code and 0xff is the opacity value and can be changed.
  static const BUTTON_TEXT = 0xffffffff;
  static const BRAND = 0xffA5A4A4;
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
        offset: const Offset(3.0, 3.0),
      ),
      BoxShadow(
        color: Colors.grey.shade400,
        spreadRadius: 0.0,
        blurRadius: 1.5 / 2.0,
        offset: const Offset(3.0, 3.0),
      ),
      const BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 1.5,
        offset: Offset(-3.0, -3.0),
      ),
      const BoxShadow(
        color: Colors.white,
        spreadRadius: 2.0,
        blurRadius: 1.5 / 2,
        offset: Offset(-3.0, -3.0),
      ),
    ],
  );
}
