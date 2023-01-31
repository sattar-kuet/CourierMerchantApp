import '../remote/api.dart';

class UserService {
  Future<dynamic> isUserExist(String mobile, context) async {
    var data = {
      'params': {
        'phone': mobile,
      }
    };
    var response = await CallApi().postData(data, 'user/login', context);
    return response['result'];
  }
}
