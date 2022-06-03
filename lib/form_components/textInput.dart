import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class textInput extends StatelessWidget {
  const textInput({
    Key? key,
    required this.label,
    required this.inputController,
    required this.inputIcon,
    this.helperText,
    this.suffixHelpText,
  }) : super(key: key);

  final String label;
  final TextEditingController inputController;
  final Icon inputIcon;
  final Widget? suffixHelpText;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText != null ? helperText : '',
        icon: inputIcon,
        suffixIcon: suffixHelpText,
      ),
    );
  }
}
