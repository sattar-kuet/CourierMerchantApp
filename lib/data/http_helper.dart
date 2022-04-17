import 'dart:io';

import 'package:flutter_app/model/user.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as Constants;
import 'dart:convert';

class HttpHelper {
  final String authority = Constants.AUTHORITY;
  final String path = 'api/v2';

  // Future<bool> isUserExist(String mobile) async {
  //   Uri uri = Uri.https(authority, path + '/isUserExist/' + mobile);
  //   http.Response respose = await http.get(uri);
  //   Map<String, dynamic> data = json.decode(respose.body);
  //   return data['user_exist'];
  // }

  // Future<String> sendOtp(String mobile) async {
  //   Uri uri = Uri.https(authority, path + '/sendOtp/' + mobile);
  //   print(uri);
  //   http.Response respose = await http.get(uri);
  //   Map<String, dynamic> data = json.decode(respose.body);
  //   //print();
  //   return data['otp'].toString();
  // }

  Future<User> sendOtp(String mobile) async {
    final String url =
        'https://courierdemo.itscholarbd.com/api/v2/sendOtp/$mobile';
    final client = new http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      //body: json.encode(user.toMapPhoneCheck()),
    );
    if (response.statusCode == 200) {
      return User.otpJSONMap(json.decode(response.body));
    } else {
      print(response.statusCode);
      throw new Exception(response.body);
    }
  }

  Future<User> isUserExist(String mobile) async {
    final String url =
        'https://courierdemo.itscholarbd.com/api/v2/isUserExist/$mobile';
    final client = new http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      //body: json.encode(user.toMapPhoneCheck()),
    );
    if (response.statusCode == 200) {
      return User.fromPhoneJSONMap(json.decode(response.body));
    } else {
      print(response.statusCode);
      throw new Exception(response.body);
    }
  }
}
