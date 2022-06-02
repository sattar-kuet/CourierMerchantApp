import 'package:flutter/material.dart';
import 'package:flutter_app/model/mobile_bank.dart';
import 'package:flutter_app/model/pickup_point.dart';
import '../model/user.dart';
import '../fragments/new_pickup_point.dart';
import '../model/bank.dart';
import '../utility/helper.dart';
import './api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constants.dart' as Constents;

class Service {
  Future<bool> isUserExist(String mobile, context) async {
    var token = await _getToken();
    var data = {'mobile': mobile, 'token': token};
    var response = await CallApi().postData(data, 'isUserExist', context);
    return response['user_exist'];
  }

  Future<String> sendOtp(String mobile, String signatureCode, context) async {
    var token = await _getToken();
    var data = {
      'mobile': mobile,
      'signatureCode': signatureCode,
      'token': token
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
        PickupPoint pickupPoint =
            await getPickupPointObjectFromJson(response['pickupPoint']);

        PickupPoint.writeSession(pickupPoint);
      }
    }
    return response;
  }

  Future<PickupPoint> getPickupPointObjectFromJson(pickupPointJson) async {
    PickupPoint pickupPoint = PickupPoint(
        pickupPointJson['id'],
        pickupPointJson['districtId'],
        pickupPointJson['upazillaId'],
        pickupPointJson['title'],
        pickupPointJson['street']);
    return pickupPoint;
  }

  Future<int> nextStepToFinishProfile(context) async {
    User loggedInUser = await User.readSession();
    var data = {'user_id': loggedInUser.id};
    var response =
        await CallApi().postData(data, 'nextStepToFinishProfile', context);
    return response['type'];
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

  Future<dynamic> getParcelTypes() async {
    var token = await _getToken();
    var response = await CallApi().getData('productTypes');
    return response['data'];
  }

  Future<dynamic> getDistrictList() async {
    var token = await _getToken();
    var response = await CallApi().getData('pickupPointDistrictList');
    return response['data'];
  }

  Future<dynamic> getBankList(context) async {
    var token = await _getToken();
    var response = await CallApi().getData('getBankList');
    var banks = response['data'];
    return banks;
  }

  Future getUpazillaList(districtId, context) async {
    var token = await _getToken();
    var data = {'district_id': districtId, 'token': token};
    var response = await CallApi().postData(data, 'upazillaList', context);
    print(response);
    return response['data'];
  }

  Future getPickupAddress(context) async {
    User sessionUser = await User.readSession();
    var data = {"user_id": sessionUser.id};
    var response = await CallApi().postData(data, 'getPickupAddress', context);
    return response['data'];
  }

  Future<dynamic> savePickupPoint(
      String title, int district, int upazilla, String street, context) async {
    User sessionUser = await User.readSession();
    var data = {
      'user_id': sessionUser.id,
      'token': sessionUser.token,
      'pickupPoint': {
        'title': title,
        'districtId': district,
        'upazillaId': upazilla,
        'street': street
      },
    };
    var response = await CallApi().postData(data, 'savePickupPoint', context);
    PickupPoint pickupPoint =
        await getPickupPointObjectFromJson(response['pickupPoint']);
    PickupPoint.writeSession(pickupPoint);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => NewPickupPoint()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response['message']),
      duration: Duration(seconds: 2),
    ));
    return response['data'];
  }

  Future saveBank(dynamic data, BuildContext context) async {
    User sessionUser = await User.readSession();
    data['token'] = sessionUser.id;
    data['userId'] = sessionUser.id;
    var response = await CallApi().postData(data, 'saveBank', context);
    print(response);
    return response['data'];
  }

  Future getBank(BuildContext context) async {
    User sessionUser = await User.readSession();
    dynamic data = {};
    data['token'] = sessionUser.token;
    data['userId'] = sessionUser.id;
    var response = await CallApi().postData(data, 'getBank', context);
    //print(response);
    var bankData = response['data'];
    if (bankData.length == 0) {
      return null;
    }
    if (bankData['bankType'] == Constents.BankAccountType.MOBILE) {
      return MobileBank(bankData['bankId'], bankData['mobileNumber'],
          bankData['accountType'], bankData['bankType']);
    }
    return Bank(
        bankData['bankId'],
        bankData['accountName'],
        bankData['accountNumber'],
        bankData['branchName'],
        bankData['bankType']);
  }

  Future getDeliverySpeedList(data, context) async {
    User sessionUser = await User.readSession();
    data['token'] = sessionUser.token;
    data['userId'] = sessionUser.id;
    var response = await CallApi().postData(data, 'getDeliverySpeeds', context);
    //print(response);
    var bankData = response['data'];
    if (bankData.length == 0) {
      return null;
    }
    if (bankData['bankType'] == Constents.BankAccountType.MOBILE) {
      return MobileBank(bankData['bankId'], bankData['mobileNumber'],
          bankData['accountType'], bankData['bankType']);
    }
    return Bank(
        bankData['bankId'],
        bankData['accountName'],
        bankData['accountNumber'],
        bankData['branchName'],
        bankData['bankType']);
  }

  dynamic _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }
}
