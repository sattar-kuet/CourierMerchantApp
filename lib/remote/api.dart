import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as Constants;

class CallApi {
  final String _url = Constants.BASE_URL;
  final excludeToLoading = ['getDeliveryCharge', 'getCodCharge'];
  Future<Map<String, dynamic>> postData(data, apiUrl, context) async {
    if (!excludeToLoading.contains(apiUrl)) {
      showloadingDialog(context);
    }

    String fullUrl = '$_url/$apiUrl';
    var url = Uri.parse(fullUrl);
    debugPrint('$url');
    var response = await http.post(url, body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> responseData = json.decode(response.body);
    // For dismissing Loading
    if (!excludeToLoading.contains(apiUrl)) {
      Navigator.of(context).pop();
    }
    // Also need to dismiss the loader because it makes trouble if the function not works properly due to internet connection etc
    //  For that rason I am adding one more condition so it can dismiss on any condition
    if (response.statusCode != 200) {
    } else {}
    return responseData;
  }

  Future<Map<String, dynamic>> getData(apiUrl) async {
    String fullUrl = '$_url/$apiUrl';
    var url = Uri.parse(fullUrl);
    var response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    Map<String, dynamic> responseData = json.decode(response.body);
    return responseData;
  }
}
