enum UserState { available, away, busy }

class User {
  bool? userExist;
  int? status;
  int? otp;

  User();

  User.fromPhoneJSONMap(Map<String, dynamic> jsonMap) {
    try {
      status = jsonMap['status'];
      userExist =
          jsonMap['userExist'] != null ? jsonMap['userExist'] : false;
    } catch (e) {
      print(e.toString());
    }
  }

  User.otpJSONMap(Map<String, dynamic> jsonMap) {
    try {
      status = jsonMap['status'];
      otp = jsonMap['otp'];
    } catch (e) {
      print(e.toString());
    }
  }
}
