import 'package:http/http.dart' as http;
import '../constants.dart' as Constants;
import 'dart:convert';

class HttpHelper {

  final String authority = Constants.AUTHORITY;
  final String path = 'api/v2';

  Future<bool> isUserExist(String mobile) async {
    Uri uri = Uri.https(authority, path + '/isUserExist/' + mobile);
    http.Response respose = await http.get(uri);
    Map<String, dynamic> data = json.decode(respose.body);
    return data['user_exist'];
  }

  Future<String> sendOtp(String mobile) async {
    Uri uri = Uri.https(authority, path + '/sendOtp/' + mobile);
    print(uri);
    http.Response respose = await http.get(uri);
    Map<String, dynamic> data = json.decode(respose.body);
    //print();
    return data['otp'].toString();
  }

}
