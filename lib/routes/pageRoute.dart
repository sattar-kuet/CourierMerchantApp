import 'package:flutter_app/fragments/profile_details.dart';

import '../fragments/intro_screen.dart';
import '../fragments/registration.dart';
import '../fragments/otp_validation.dart';
import '../fragments/login_by_password.dart';
import '../fragments/home.dart';
import '../fragments/new_pickup_point.dart';
import '../fragments/new_parcel_screen.dart';

class PageRoutes {
  static const String login = IntroPage.routeName;
  static const String otpValidation = OtpValidationPage.routeName;
  static const String loginByPassword = LoginByPasswordPage.routeName;
  static const String registration = RegistrationPage.routeName;
  static const String home = Home.routeName;
  static const String newPickupPoint = NewPickupPoint.routeName;
  static const String profile = ProfileDetails.routeName;
  static const String NewParcel = NewParcelPage.routeName;
}
