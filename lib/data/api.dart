import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart' as Constants;

class CallApi {
  final String _url = Constants.BASE_URL;

  Future<Map<String, dynamic>> postData(data, apiUrl) async {
     String fullUrl = '$_url/$apiUrl/' + await _getToken();
    var url = Uri.parse(fullUrl);
    print(url);
    var response =
        await http.post(url, body: jsonEncode(data), headers: _setHeaders());
    Map<String, dynamic> responseData = json.decode(response.body);    
    return responseData;
  }

  Future<Map<String, dynamic>> getData(apiUrl) async {
    String fullUrl = '$_url/$apiUrl/' + await _getToken();
    var url = Uri.parse(fullUrl);
    var response = await http.get(url, headers: _setHeaders());
    Map<String, dynamic> responseData = json.decode(response.body);    
    return responseData;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '$token';
  }
}
