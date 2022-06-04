import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

class FormButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  const FormButton({Key? key, required this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color(
              Constants.Color.BUTTON_TEXT,
            ),
            fontSize: 18,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Color(Constants.Color.BUTTON_BG),
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: Color(Constants.Color.BUTTON_BG),
          width: 1.0,
        ),
      ),
    );
  }
}
