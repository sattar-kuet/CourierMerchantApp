//import 'dart:io';
//import 'package:flutter_app/model/user.dart';

import 'package:flutter_app/utility/helper.dart';

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
 

  Future<dynamic> getAreaList(districtId) async {
    var token = await _getToken();
    var data = {'district_id': districtId};
    var response = await CallApi().postData(data, 'pickupPointAreaList');
    return response['data'];
  }

  Future<dynamic> addPickupPoint(
      String title, int district, int area, String street) async {
    var token = await _getToken();
    var data = {
      'user_id': Helper.getLoggedInUserId(),
      'address': {
        'title': title,
        'district': district,
        'area': area,
        'street': street
      },
    };
    var response = await CallApi().postData(data, 'addPickupPoint');
    return response['data'];
  }

  dynamic _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }
}
