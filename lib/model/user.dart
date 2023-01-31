import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  int uid = 0;
  String sessionId = '';
  String name = '';
  int companyId = 0;
  int partnerId = 0;
  int status = 0;
  String message = ' ';

  User(this.uid, this.sessionId, this.name, this.companyId, this.partnerId,
      this.status, this.message);

  User.fromJson(Map<String, dynamic> sessionMap) {
    uid = sessionMap['uid'] ?? 0;
    sessionId = sessionMap['session_id'] ?? '';
    name = sessionMap['name'] ?? '';
    companyId = sessionMap['company_id'] ?? 0;
    partnerId = sessionMap['partner_id'] ?? 0;
    status = sessionMap['status'] ?? 0;
    message = sessionMap['message'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'sessionId': sessionId,
      'name': name,
      'companyId': companyId,
      'partnerId': partnerId,
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
        : User(0, '', '', '', 0, 0, '');
  }
}
