import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart' as Constants;
import '../model/user.dart';
import '../remote/api.dart';

class RegisterLoginService {
  Future<String> sendOtp(String mobile, String signatureCode, context) async {
    User user = await User.readSession();
    var data = {'mobile': mobile, 'signatureCode': signatureCode, 'token': user.sessionId};
    var response = await CallApi().postData(data, 'sendOtp', context);
    return response['otp'].toString();
  }

  dynamic login_old(String login, String password, context) async {
    var data = {
      "params": {
        "db": Constants.DATABASE,
        "login": login,
        "password": password,
      }
    };
    Map response = await CallApi().postData(data, 'web/session/authenticate', context);
    if (response.containsKey('error')) {
      debugPrint(" পাসওয়ার্ড অথবা মোবাইল নাম্বার ভুল।");
    } else {
      debugPrint(response.toString());
    }

    // if (response['status'] == 1) {
    //   User user = User(
    //       response['uid'],
    //       response['token'],
    //       response['user']['name'],
    //       response['user']['mobile'],
    //       response['user']['company_profile_id'],
    //       response['status'],
    //       response['message']);
    //   User.writeSession(user);

    //   if (response['pickupPoint'].length > 0) {
    //     PickupPoint pickupPoint = await PickupPointService()
    //         .getPickupPointObjectFromJson(response['pickupPoint']);

    //     PickupPoint.writeSession(pickupPoint);
    //   }
    // }
    return response;
  }

  Future<bool> login(String login, String password, dynamic context) async {
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
      final response = await http.post(url, body: body, headers: headers);
      debugPrint('response $response.body');
      final cookies = response.headers['set-cookie'];
      debugPrint('Cookies $cookies');

      if (cookies != null) {
        final entity = cookies.split("; ").map((item) {
          final split = item.split("=");

          return (split.length == 2) ? MapEntry(split[0], split[1]) : MapEntry(split[0], '/');
        });
        final cookieMap = Map.fromEntries(entity);

        //save this authToken in local storage, and pass in further api calls.

        debugPrint(cookieMap.toString());
        debugPrint('session_id: ${cookieMap['session_id']}');
      }

      final responseBody = response.body;
      final Map<String, dynamic> json = jsonDecode(responseBody);

      final user = User.fromJson(json['result']);

      debugPrint(user.toString());
      return true;
    } catch (e) {
      debugPrint('Failed to read cookies from API: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> register(String mobile, String name, String businessName, int productTypeId, context) async {
    var data = {
      'mobile': mobile,
      'name': name,
      'businessName': businessName,
      'productTypeId': productTypeId,
    };
    var response = await CallApi().postData(data, 'register', context);
    if (response['status'] == 1) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', response['token']);
      localStorage.setString('user', json.encode(response['user']));
    }
    return response;
  }

  Future<int> nextStepToFinishProfile(context) async {
    User loggedInUser = await User.readSession();
    var data = {'user_id': loggedInUser.uid};
    var response = await CallApi().postData(data, 'nextStepToFinishProfile', context);
    return response['type'];
  }
}
