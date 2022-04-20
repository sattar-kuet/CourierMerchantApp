import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as Constants;

class CallApi {
  final String _url = Constants.BASE_URL;

  Future<Map<String, dynamic>> postData(data, apiUrl) async {
     EasyLoading.show(status: 'Please wait...');
    String fullUrl = '$_url/$apiUrl';
    var url = Uri.parse(fullUrl);
    print(url);
    var response = await http.post(url, body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData != null) {
      EasyLoading.dismiss();
    }
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
