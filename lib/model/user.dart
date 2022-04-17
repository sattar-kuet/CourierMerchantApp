import 'package:flutter/material.dart';

enum UserState { available, away, busy }

class User {
  bool? user_exist;
  int? status;
  int? otp;

  User();

  User.fromPhoneJSONMap(Map<String, dynamic> jsonMap) {
    try {
      status = jsonMap['status'];
      user_exist =
          jsonMap['user_exist'] != null ? jsonMap['user_exist'] : false;
    } catch (e) {
      print(e.toString());
    }
  }

  User.otpJSONMap(Map<String, dynamic> jsonMap) {
    try {
      status = jsonMap['status'];
      otp = jsonMap['otp'];
    } catch (e) {
      print(e.toString());
    }
  }
}
