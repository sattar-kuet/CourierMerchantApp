import '../model/user.dart';
import '../remote/api.dart';

class UserService {
  Future<bool> isUserExist(String mobile, context) async {
    User user = await User.readSession();
    var data = {'mobile': mobile, 'token': user.token};
    var response = await CallApi().postData(data, 'isUserExist', context);
    return response['user_exist'];
  }
}
