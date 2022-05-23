import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class numberInput extends StatelessWidget {
  const numberInput({
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
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        icon: inputIcon,
      ),
    );
  }
}
