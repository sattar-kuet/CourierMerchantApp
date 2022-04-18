//import 'dart:io';
//import 'package:flutter_app/model/user.dart';
import './api.dart';

class Service {
  Future<bool> isUserExist(String mobile) async {
    var data = {'mobile': mobile};
    var response = CallApi().postData(data, 'isUserExist');
    return response['user_exist'];
  }

  Future<void> sendOtp(String mobile, String signatureCode) async {
    var data = {'mobile': mobile, 'signatureCode': signatureCode};
    var response = CallApi().postData(data, 'sendOtp');
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
}
