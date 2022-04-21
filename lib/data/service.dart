//import 'dart:io';
//import 'package:flutter_app/model/user.dart';

import './api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Service {
  Future<bool> isUserExist(String mobile) async {
    var token = await _getToken();
    var data = {'mobile': mobile, 'token': token};
    var response = await CallApi().postData(data, 'isUserExist');
    return response['user_exist'];
  }

  Future<String> sendOtp(String mobile, String signatureCode) async {
    var token = await _getToken();
    var data = {
      'mobile': mobile,
      'signatureCode': signatureCode,
      'token': token
    };
    var response = await CallApi().postData(data, 'sendOtp');
    return response['otp'].toString();
  }

  Future<Map<String, dynamic>> login(String mobile, String otp) async {
    var data = {'mobile': mobile, 'otp': otp};
    var response = await CallApi().postData(data, 'login');
    if (response['status'] == 1) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', response['token']);
      localStorage.setString('user', json.encode(response['user']));
    }
    return response;
  }

  // Future<User> sendOtp(String mobile, String signatureCode) async {
  //   final String url =
  //       'https://courierdemo.itscholarbd.com/api/v2/sendOtp/$mobile/$signatureCode';
  //   final client = new http.Client();
  //   final response = await client.get(
  //     Uri.parse(url),
  //     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //     //body: json.encode(user.toMapPhoneCheck()),
  //   );
  //   if (response.statusCode == 200) {
  //     return User.otpJSONMap(json.decode(response.body));
  //   } else {
  //     print(response.statusCode);
  //     throw new Exception(response.body);
  //   }
  // }

  // Future<User> isUserExist(String mobile) async {
  //   final String url =
  //       'https://courierdemo.itscholarbd.com/api/v2/isUserExist/$mobile';
  //   final client = new http.Client();
  //   final response = await client.get(
  //     Uri.parse(url),
  //     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //     //body: json.encode(user.toMapPhoneCheck()),
  //   );
  //   if (response.statusCode == 200) {
  //     return User.fromPhoneJSONMap(json.decode(response.body));
  //   } else {
  //     print(response.statusCode);
  //     throw new Exception(response.body);
  //   }
  // }
  dynamic _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }
}
