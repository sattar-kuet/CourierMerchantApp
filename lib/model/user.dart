import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  int id = 0;
  String token = '';
  String name = '';
  String mobile = '';
  int companyProfileId = 0;
  int status = 0;
  String message = ' ';

  User(this.id, this.token, this.name, this.mobile, this.companyProfileId,
      this.status, this.message);

  User.fromJson(Map<String, dynamic> sessionMap) {
    id = sessionMap['id'] ?? 0;
    token = sessionMap['token'] ?? '';
    name = sessionMap['name'] ?? '';
    mobile = sessionMap['mobile'] ?? '';
    companyProfileId = sessionMap['companyProfileId'] ?? 0;
    status = sessionMap['status'] ?? 0;
    message = sessionMap['message'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'mobile': mobile,
      'companyProfileId': companyProfileId,
      'status': status,
      'message': message,
    };
  }

  static Future writeSession(User user) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('user', json.encode(user.toJson()));
  }

  static Future<User> readSession() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var sessionUser = localStorage.getString('user');
    return sessionUser != null
        ? User.fromJson(json.decode(sessionUser))
        : new User(0, '', '', '', 0, 0, '');
  }
}
