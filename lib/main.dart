import 'dart:io';

import 'package:flutter/material.dart';

//import 'package:flutter_app/fragments/login_by_otp.dart';
import 'package:flutter_app/fragments/login_by_password.dart';

//import 'package:flutter_app/fragments/profile_details.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_app/fragments/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fragments/intro_screen.dart';
import './routes/pageRoute.dart';
import 'utility/helper.dart';



void main() async {
  HttpOverrides.global = MyHttpOverrides();
  Helper.sharedPreference = await SharedPreferences.getInstance();
  runApp(const CourierApp());
}

class CourierApp extends StatelessWidget {
  const CourierApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'startapp',
      home: const IntroPage(),
      routes: {
        PageRoutes.login: (context) => const IntroPage(),
        PageRoutes.registration: (context) => const RegistrationPage(),
        PageRoutes.loginByPassword: (context) => const LoginByPasswordPage(),
        //PageRoutes.loginByOtp: (context) => LoginbyotpPage(),
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
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
