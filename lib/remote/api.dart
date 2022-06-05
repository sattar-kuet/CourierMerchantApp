import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as Constants;

class CallApi {
  final String _url = Constants.BASE_URL;

  Future<Map<String, dynamic>> postData(data, apiUrl, context) async {
    if (apiUrl != 'getDeliveryCharge') {
      showloadingDialog(context);
    }

    String fullUrl = '$_url/$apiUrl';
    var url = Uri.parse(fullUrl);
    print(url);
    var response = await http.post(url, body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> responseData = json.decode(response.body);
    // For dismissing Loading
    if (apiUrl != 'getDeliveryCharge') {
      Navigator.of(context).pop();
    }
    // Also need to dismiss the loader because it makes trouble if the function not works properly due to internet connection etc
    //  For that rason I am adding one more condition so it can dismiss on any condition
    if (response.statusCode != 200) {
      if (responseData != null) {}
    } else {}
    return responseData;
  }

  Future<Map<String, dynamic>> getData(apiUrl) async {
    String fullUrl = '$_url/$apiUrl';
    var url = Uri.parse(fullUrl);
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> responseData = json.decode(response.body);
    return responseData;
  }
}
