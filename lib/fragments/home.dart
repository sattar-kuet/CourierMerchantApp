import 'package:flutter/material.dart';
import '../common/menu_drawer.dart';
import '../common/bottom_navigation.dart';
import '../common/floating_button.dart';

class Home extends StatelessWidget {
  static const String routeName = '/homePage';

  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: MenuDrawer(),
      body: const Center(child: Text("This is Home")),
      bottomNavigationBar: const BottomNavigation(),
      floatingActionButton: floating(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
