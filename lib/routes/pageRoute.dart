import 'package:flutter_app/fragments/profile_details.dart';

import '../fragments/intro_screen.dart';
import '../fragments/registration.dart';
import '../fragments/login_by_otp.dart';
import '../fragments/home.dart';

class PageRoutes {
  static const String login = IntroPage.routeName;
  static const String loginByOtp = LoginbyotpPage.routeName;
  static const String registration = RegistrationPage.routeName;
  static const String home = HomePage.routeName;
  static const String profile = ProfileDetails.routeName;
}
