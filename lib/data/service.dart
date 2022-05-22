import 'package:flutter/material.dart';
import '../data/user.dart';
import '../model/bank.dart';
import '../fragments/new_pickup_point.dart';
import '../utility/helper.dart';
import './api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
    }
    return response;
  }

  Future<int> nextStepToFinishProfile(context) async {
    var loggedInUserId = await _getLoggedInUser('id');
    var data = {'user_id': loggedInUserId};
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

  Future<dynamic> getProductTypes() async {
    var token = await _getToken();
    var response = await CallApi().getData('productTypes');
    return response['data'];
  }

  Future<dynamic> getDistrictList() async {
    var token = await _getToken();
    var response = await CallApi().getData('pickupPointDistrictList');
    return response['data'];
  }

  Future<dynamic> getBankList() async {
    var token = await _getToken();
    var response = await CallApi().getData('getBankList');
    var banks = response['data'];
    // List<Map<int,int>> mobileBanksHashTable = [];
    // for (var bank in banks){
    //      int id = bank['id'];
    //      int type = bank['type'];
    //       mobileBanksHashTable
    //         .add(Map(id,type));
    // }
    // Bank.writeSession(mobileBanksHashTable);
    return banks;
  }

  Future getAreaList(districtId, context) async {
    var token = await _getToken();
    var data = {'district_id': districtId, 'token': token};
    var response = await CallApi().postData(data, 'upazillaList', context);
    print(response);
    return response['data'];
  }

  Future getPickupAddress(context) async {
    int userId = await Helper().getLoggedInUserId();
    var data = {"user_id": userId};
    var response = await CallApi().postData(data, 'getPickupAddress', context);
    print(response);
    return response['data'];
  }

  Future<dynamic> editPickupPoint(
      String title, int district, int area, String street, id, context) async {
    var token = await _getToken();
    var userId = await Helper().getLoggedInUserId();
    var data = {
      'user_id': userId,
      'token': token,
      'address': {
        'id': id,
        'title': title,
        'district': district,
        'upazilla': area,
        'street': street
      },
    };
    var response = await CallApi().postData(data, 'updatePickupPoint', context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => NewPickupPoint()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response['message']),
      duration: Duration(seconds: 2),
    ));
    return response['data'];
  }

  Future<dynamic> addPickupPoint(
      String title, int district, int area, String street, context) async {
    var token = await _getToken();
    var userId = await Helper().getLoggedInUserId();
    var data = {
      'user_id': userId,
      'token': token,
      'address': {
        'title': title,
        'district': district,
        'upazilla': area,
        'street': street
      },
    };

    var response = await CallApi().postData(data, 'addPickupPoint', context);
    print(response);
    // This Navigator.pop() is for closing model sheet
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response['message']),
      duration: Duration(seconds: 2),
    ));
    return response['data'];
  }

  dynamic _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }

  dynamic _getLoggedInUser(String key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userData = localStorage.getString('user');
    return 1;
    // return userData!.key;
  }
}
