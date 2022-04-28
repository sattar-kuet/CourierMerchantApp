import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
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

  Future<int> getLoggedInUserId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userId = json.decode(localStorage.getString('user').toString());
    return userId['id'];
  }
}
