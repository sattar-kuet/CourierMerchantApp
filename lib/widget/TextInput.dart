import 'package:flutter/material.dart';
import '../utility/validatation.dart';
class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.inputController,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final TextEditingController inputController;
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        prefixIcon: Icon(icon),
        labelText: label,
      ),
      validator: (value) {
        return Validation.required(value);
      },
    );
  }
}