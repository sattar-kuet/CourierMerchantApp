import '../remote/api.dart';
import '../model/user.dart';
import '../model/customer.dart';

class CustomerService {
  Future<Customer> getCustomerByMobile(String mobile, context) async {
    User user = await User.readSession();
    var data = {'mobile': mobile, 'token': user.token};
    var response =
        await CallApi().postData(data, 'getCustomerByMobile', context);
    var customerData = response['data'];
    if (customerData.length == 0) {
      return Customer(0, '', '', '', 0, 0, 0, '');
    }
    Customer customer = Customer(
        customerData['id'],
        customerData['name'],
        customerData['mobile'],
        customerData['alternativeMobile'],
        customerData['districtId'],
        customerData['upazillaId'],
        customerData['areaId'],
        customerData['address']);
    return customer;
  }
}
