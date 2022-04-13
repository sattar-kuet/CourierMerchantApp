import 'package:flutter/material.dart';
import 'package:flutter_app/bottom_navigation.dart';
import 'package:flutter_app/floating_button.dart';

void main() => runApp(CourierApp());

class CourierApp extends StatelessWidget {
  const CourierApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'startapp',
      home: Scaffold(
        appBar: AppBar(title: Text('custom navigation')),
        backgroundColor: Colors.blueAccent,
        floatingActionButton: floating,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}
