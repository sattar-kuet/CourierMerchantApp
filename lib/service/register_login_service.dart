import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/utility/helper.dart';

import '../constants.dart' as Constants;
import '../model/user.dart';
import '../remote/api.dart';
import '../widget/loading.dart';

class RegisterLoginService {
  Future<dynamic> sendOtp(String phone, String message, context) async {
    var data = {
      "params": {'phone': phone, 'message': 'message'}
    };
    var response = await CallApi().postData(data, 'password/sendotp', context);
    print(response);
    return response;
  }

  Future<dynamic> login(String login, String password, dynamic context) async {
    final url = Uri.parse('${Constants.BASE_URL}/web/session/authenticate');
    final body = jsonEncode({
      "params": {
        "db": Constants.DATABASE,
        "login": login,
        "password": password,
      }
    });
    final headers = {"Content-Type": "application/json"};
    try {
      showloadingDialog(context);
      final response = await http.post(url, body: body, headers: headers);
      debugPrint('response $response.body');
      final cookies = response.headers['set-cookie'];
      debugPrint('Cookies $cookies');

      if (cookies != null) {
        final entity = cookies.split("; ").map((item) {
          final split = item.split("=");

          return (split.length == 2)
              ? MapEntry(split[0], split[1])
              : MapEntry(split[0], '/');
        });
        final cookieMap = Map.fromEntries(entity);

        //save this authToken in local storage, and pass in further api calls.

        debugPrint(cookieMap.toString());
        debugPrint('session_id: ${cookieMap['session_id']}');
        Helper.setSessionId(cookieMap['session_id']!);
      }

      final responseBody = response.body;
      final Map<String, dynamic> json = jsonDecode(responseBody);

      final user = User.fromJson(json['result']);
      Helper.setUserId(user.uid);
      debugPrint(user.toString());
      return {'status': true, 'user': user};
    } catch (e) {
      debugPrint('Failed to read cookies from API: $e');
      return {'status': false};
    }
  }

  Future<dynamic> register(String name, String email, String phone,
      String company, String password, context) async {
    var data = {
      "params": {
        'name': name,
        'email': email,
        'phone': phone,
        'company': company,
        'password': password,
      }
    };
    var response =
        await CallApi().postData(data, 'api/custom/registration', context);
    return response['result'];
  }

  // Future<int> nextStepToFinishProfile(context) async {
  //   User loggedInUser = await User.readSession();
  //   var data = {'user_id': loggedInUser.uid};
  //   var response =
  //       await CallApi().postData(data, 'nextStepToFinishProfile', context);
  //   return response['type'];
  // }
}
