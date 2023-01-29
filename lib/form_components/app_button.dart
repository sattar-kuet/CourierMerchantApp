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
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(Constants.Color.BUTTON_BG),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ));
  }
}
