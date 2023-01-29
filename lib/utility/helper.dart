
import 'package:flutter/material.dart';

class Helper {
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
}

class UserPickUpAddressesHelper {
  List userPickupPoint = [];
}
