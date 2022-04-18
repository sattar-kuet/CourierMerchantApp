//import 'dart:io';
//import 'package:flutter_app/model/user.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as Constants;
import 'dart:convert';

class HttpHelper {
  final String baseUrl = Constants.BASE_URL;

  Future<bool> isUserExist(String mobile) async {
     var url = Uri.parse('$baseUrl/isUserExist');
    var response = await http.post(url, body: {'mobile': mobile});
    Map<String, dynamic> data = json.decode(response.body);
    return data['user_exist'];
  }

  Future<String> sendOtp(String mobile, String signatureCode) async {
    var url = Uri.parse('$baseUrl/sendOtp');
    var response = await http.post(url, body: {'mobile': mobile, 'signatureCode': signatureCode});
    Map<String, dynamic> data = json.decode(response.body);
    return data['otp'];
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
