import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/fragments/login_by_otp.dart';
//import 'package:flutter_app/fragments/profile_details.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_app/fragments/registration.dart';
import 'fragments/intro_screen.dart';
import './routes/pageRoute.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(CourierApp());
}

class CourierApp extends StatelessWidget {
  const CourierApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'startapp',
      home: IntroPage(),
      routes: {
        PageRoutes.login: (context) => IntroPage(),
        PageRoutes.registration: (context) => RegistrationPage(),
        PageRoutes.loginByOtp: (context) => LoginbyotpPage(),
        // PageRoutes.profile: (context) => ProfileDetails(),
      },
      builder: EasyLoading.init(),

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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
