import 'package:flutter/material.dart';
import 'package:flutter_app/fragments/registration.dart';
// import './common/bottom_navigation.dart';
// import './common/floating_button.dart';
import './fragments/login.dart';
import './routes/pageRoute.dart';

void main() => runApp(CourierApp());

class CourierApp extends StatelessWidget {
  const CourierApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'startapp', home: LoginPage(), routes: {
      PageRoutes.login: (context) => LoginPage(),
      PageRoutes.registration: (context) => RegistrationPage(),
    }
        // home: Scaffold(
        //   appBar: AppBar(title: Text('custom navigation')),
        //   backgroundColor: Colors.blueAccent,
        //   floatingActionButton: floating,
        //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //   bottomNavigationBar: BottomNavigation(),
        // ),
        );
  }
}
