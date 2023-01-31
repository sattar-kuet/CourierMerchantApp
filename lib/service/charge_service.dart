import 'package:flutter/foundation.dart';

import '../model/user.dart';
import '../remote/api.dart';
import '../utility/helper.dart';

class ChargeService {
  Future<double> getDeliveryCharge(data, context) async {
    data['userId'] = Helper.getUserId();
    var response = await CallApi().postData(data, 'getDeliveryCharge', context);
    double deliveryCharge = double.parse(response['data'].toString());
    return deliveryCharge;
  }

  Future<double> getCodCharge(data, context) async {
    data['userId'] = Helper.getUserId();
    var response = await CallApi().postData(data, 'getCodCharge', context);
    double codCharge = double.parse(response['data'].toString());
    debugPrint('$data');
    return codCharge;
  }

  Future getDeliverySpeedList(
      fromUpazillaId, toUpazillaId, parcelTypeId, context) async {
    var data = {};
    data['fromUpazillaId'] = fromUpazillaId;
    data['toUpazillaId'] = toUpazillaId;
    data['parcelTypeId'] = parcelTypeId;
    data['userId'] = Helper.getUserId();
    var response = await CallApi().postData(data, 'getDeliverySpeeds', context);
    //print(response);
    return response['data'];
  }
}
