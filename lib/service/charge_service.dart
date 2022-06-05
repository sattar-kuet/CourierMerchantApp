import '../model/user.dart';
import '../remote/api.dart';

class ChargeService {
  Future<double> getDeliveryCharge(data, context) async {
    User user = await User.readSession();
    data['userId'] = user.id;
    var response = await CallApi().postData(data, 'getDeliveryCharge', context);
    double deliveryCharge = double.parse(response['data'].toString());
    return deliveryCharge;
  }

  Future getDeliverySpeedList(
      fromUpazillaId, toUpazillaId, parcelTypeId, context) async {
    User sessionUser = await User.readSession();
    var data = {};
    data['fromUpazillaId'] = fromUpazillaId;
    data['toUpazillaId'] = toUpazillaId;
    data['parcelTypeId'] = parcelTypeId;

    data['token'] = sessionUser.token;
    data['userId'] = sessionUser.id;
    var response = await CallApi().postData(data, 'getDeliverySpeeds', context);
    //print(response);
    return response['data'];
  }
}
