import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static late SharedPreferences sharedPreference;
  List userPickupPoint = [];

  static void errorSnackbar(BuildContext context, String message) {
    final errorSnackbar = SnackBar(
      backgroundColor: Colors.deepOrange,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
  }

  static String? getUserId() => sharedPreference.getString('user');

  static Future<bool> setUserId(String newId) => sharedPreference.setString('user', newId);
}

class UserPickUpAddressesHelper {
  List userPickupPoint = [];
}
