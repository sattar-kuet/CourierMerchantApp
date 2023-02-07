import 'package:flutter/foundation.dart';

@immutable
class User {
  const User({
    required this.uid,
    required this.sessionId,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
  });

  final int uid;
  final String? sessionId, name, email, phone, company;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'sessionId': sessionId,
      'name': name,
      'email': email,
      'phone': phone,
      'company': company
    };
  }

  @override
  String toString() {
    return 'User{uid: $uid, sessionId: $sessionId, name: $name, email: $email, phone: $phone, company: $company}';
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? 0,
      sessionId: map['session_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      company: map['company'] ?? '',
    );
  }
}
