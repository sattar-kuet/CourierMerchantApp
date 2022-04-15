import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  PersonPage({Key? key}) : super(key: key);

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("This is Person page"),
    );
  }
}
