//import 'dart:io';
//import 'package:flutter_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/fragments/new_pickup_point.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/utility/helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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

  Future<Map<String, dynamic>> register(String mobile, String name,
      String businessName, int productTypeId) async {
    var data = {
      'mobile': mobile,
      'name': name,
      'businessName': businessName,
      'productTypeId': productTypeId,
    };
    var response = await CallApi().postData(data, 'register');
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

  Future getAreaList(districtId) async {
    EasyLoading.show(status: 'Please wait...');
    var token = await _getToken();
    var data = {'district_id': districtId, 'token': token};
    var response = await CallApi().postData(data, 'upazillaList');
    print(response);
    return response['data'];
  }

  Future getPickupAddress() async {
    int userId = await Helper().getLoggedInUserId();
    var data = {"user_id": userId};
    var response = await CallApi().postData(data, 'getPickupAddress');
    print(response);
    return response['data'];
  }

  Future<dynamic> editPickupPoint(
      String title, int district, int area, String street, context) async {
    var token = await _getToken();
    var userId = await Helper().getLoggedInUserId();
    var data = {
      'user_id': userId,
      'token': token,
      'address': {
        'title': title,
        'district': district,
        'area': area,
        'street': street
      },
    };
    var response = await CallApi().postData(data, 'updatePickupPoint');
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
        'area': area,
        'street': street
      },
    };
    var response = await CallApi().postData(data, 'addPickupPoint');
    print(response);
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
}
