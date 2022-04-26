import 'package:flutter/material.dart';

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

  static int getLoggedInUserId() {
    //TODO: get user->id from : 
    // localStorage.setString('user', json.encode(response['user']));
    return 10; // this will be replaced by real logged in user id.
  }
}
