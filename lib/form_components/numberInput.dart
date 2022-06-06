import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class numberInput extends StatelessWidget {
  const numberInput({
    Key? key,
    required this.label,
    required this.inputController,
    required this.inputIcon,
    this.suffixHelpText,
    this.helperText,
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
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
        TextInputFormatter.withFunction((oldValue, newValue) {
          try {
            String text = newValue.text;
            if (text.startsWith('.')) text = '0$text';
            if (text.isNotEmpty) double.parse(text);
            return newValue;
          } catch (e) {}
          return oldValue;
        }),
      ],
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText != null ? helperText : '',
        icon: inputIcon,
        suffixIcon: suffixHelpText,
      ),
    );
  }
}
