import 'package:flutter_app/model/pickup_point.dart';
import '../service/pickup_point_service.dart';
import '../model/user.dart';
import '../remote/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegisterLoginService {
  Future<String> sendOtp(String mobile, String signatureCode, context) async {
    User user = await User.readSession();
    var data = {
      'mobile': mobile,
      'signatureCode': signatureCode,
      'token': user.token
    };
    var response = await CallApi().postData(data, 'sendOtp', context);
    return response['otp'].toString();
  }

  dynamic login(String mobile, String otp, context) async {
    var data = {'mobile': mobile, 'otp': otp};
    Map response = await CallApi().postData(data, 'login', context);
    if (response['status'] == 1) {
      User user = User(
          response['user']['id'],
          response['token'],
          response['user']['name'],
          response['user']['mobile'],
          response['user']['company_profile_id'],
          response['status'],
          response['message']);
      User.writeSession(user);

      if (response['pickupPoint'].length > 0) {
        PickupPoint pickupPoint = await PickupPointService()
            .getPickupPointObjectFromJson(response['pickupPoint']);

        PickupPoint.writeSession(pickupPoint);
      }
    }
    return response;
  }

  Future<Map<String, dynamic>> register(String mobile, String name,
      String businessName, int productTypeId, context) async {
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
    var response =
        await CallApi().postData(data, 'nextStepToFinishProfile', context);
    return response['type'];
  }
}
