import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_app/model/pickup_point.dart';
import '../service/pickup_point_service.dart';
import '../model/user.dart';
import '../remote/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constants.dart' as Constants;

class RegisterLoginService {
  Future<String> sendOtp(String mobile, String signatureCode, context) async {
    User user = await User.readSession();
    var data = {'mobile': mobile, 'signatureCode': signatureCode, 'token': user.token};
    var response = await CallApi().postData(data, 'sendOtp', context);
    return response['otp'].toString();
  }

  dynamic login(String login, String password, context) async {
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

  Future<void> readCookiesFromAPI(String login, String password, dynamic context) async {
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

      final cookies = response.headers['set-cookie'];
      debugPrint('Cookies $cookies');
      // session_id=ba2fa9e192dc8a8cb1d7a21dd3541df4d4c9cde4; Expires=Mon, 01-May-2023 08:47:54 GMT; Max-Age=7776000; HttpOnly; Path=/

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
    } catch (e) {
      debugPrint('Failed to read cookies from API: $e');
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
    var data = {'user_id': loggedInUser.id};
    var response = await CallApi().postData(data, 'nextStepToFinishProfile', context);
    return response['type'];
  }
}
