import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  static const String routeName = '/testPage';
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
