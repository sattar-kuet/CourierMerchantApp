import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class textInput extends StatelessWidget {
  const textInput({
    Key? key,
    required this.label,
    required this.inputController,
    required this.inputIcon,
  }) : super(key: key);

  final String label;
  final TextEditingController inputController;
  final Icon inputIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        icon: inputIcon,
      ),
    );
  }
}
