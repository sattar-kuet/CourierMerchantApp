import 'package:flutter/material.dart';
import '../common/menu_drawer.dart';
import '../common/bottom_navigation.dart';
import '../common/floating_button.dart';

class Bank extends StatelessWidget {
  static const String routeName = '/bankPage';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Bank"),
      ),
      drawer: MenuDrawer(),
      body: Center(child: Text("This is Home")),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: floating,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
