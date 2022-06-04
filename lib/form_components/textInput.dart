import 'package:flutter/material.dart';

class textInput extends StatelessWidget {
  const textInput({
    Key? key,
    required this.label,
    required this.inputController,
    required this.inputIcon,
    this.helperText,
    this.suffixHelpText,
    this.onChangeEvent,
  }) : super(key: key);

  final String label;
  final TextEditingController inputController;
  final Icon inputIcon;
  final Widget? suffixHelpText;
  final String? helperText;
  final Function? onChangeEvent;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      onChanged: onChangeEvent != null ? (_) => onChangeEvent!() : null,
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText != null ? helperText : '',
        icon: inputIcon,
        suffixIcon: suffixHelpText,
      ),
    );
  }
}
