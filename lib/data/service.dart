//import 'dart:io';
//import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/constants.dart';
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
 
 Future getAreaList(districtId)async{
   EasyLoading.show(status: 'Please wait...');
    String fullUrl = '$BASE_URL/upazillaList/$districtId';
    var url = Uri.parse(fullUrl);
    print(url);
    var response = await http.post(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData != null) {
      EasyLoading.dismiss();
    }
    print(responseData);
    return responseData;

 }
  Future<dynamic> getAreaList2(districtId) async {
    var token = await _getToken();
    var data = {'district_id': districtId};
    var response = await CallApi().postData(data, 'upazillaList/$districtId');
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
