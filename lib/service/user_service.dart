import '../remote/api.dart';

class UserService {
  Future<dynamic> isUserExist(String mobile, context) async {
    var data = {
      'params': {
        'phone': mobile,
      }
    };
    var response = await CallApi().postData(data, 'user/is_exist', context);
    return response['result'];
  }
}
