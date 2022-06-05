import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Color(Constants.Color.BUTTON_BG),
          ),
        ));
  }
}
