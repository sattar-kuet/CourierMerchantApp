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
      //DON'T ADD inputFormatters because : https://stackoverflow.com/questions/72514576/floating-value-formatting-in-textformfield-in-flutter
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText != null ? helperText : '',
        icon: inputIcon,
        suffixIcon: suffixHelpText,
      ),
    );
  }
}
