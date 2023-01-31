import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class User {
  const User({
    required this.uid,
    required this.sessionId,
    required this.name,
    required this.companyId,
    required this.partnerId,
    required this.status,
    required this.message,
  });

  final int? uid, companyId, partnerId, status;
  final String? sessionId, name, message;

  // User(this.uid, this.sessionId, this.name, this.companyId, this.partnerId,
  //     this.status, this.message);

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

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? 0,
      sessionId: map['session_id'] ?? '',
      name: map['name'] ?? '',
      message: map['message'] ?? '',
      companyId: map['company_id'] ?? 0,
      partnerId: map['partner_id'] ?? 0,
      status: map['status'] ?? 0,
    );
  }

// User.fromJson(Map<String, dynamic> sessionMap) {
//   uid = sessionMap['uid'] ?? 0;
//   sessionId = sessionMap['session_id'] ?? '';
//   name = sessionMap['name'] ?? '';
//   companyId = sessionMap['company_id'] ?? 0;
//   partnerId = sessionMap['partner_id'] ?? 0;
//   status = sessionMap['status'] ?? 0;
//   message = sessionMap['message'] ?? '';
// }
//
// Map<String, dynamic> toJson() {
//   return {
//     'uid': uid,
//     'sessionId': sessionId,
//     'name': name,
//     'companyId': companyId,
//     'partnerId': partnerId,
//     'status': status,
//     'message': message,
//   };
// }

  static Future writeSession(User user) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('user', json.encode(user.toJson()));
  }

  static Future<User> readSession() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var sessionUser = localStorage.getString('user');
    return User.fromJson(json.decode('$sessionUser'));
  }
}
