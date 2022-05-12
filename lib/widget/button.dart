import 'package:flutter/material.dart';

class CustumButtom extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const CustumButtom(
      {required this.text, required this.onPressed, Key? key})
      : super(key: key);

  final double borderRadius = 25;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7,bottom: 7),
      child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.blue,])),
          child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  alignment: Alignment.center,
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      right: 20, left: 20, top: 11, bottom: 11)),
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius)),
                  )),
              onPressed: onPressed,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ))),
    );
  }
}