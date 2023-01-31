import 'package:flutter/foundation.dart';

import '../model/user.dart';
import '../remote/api.dart';

class LocationService {
  Future<dynamic> getDistrictList() async {
    var response = await CallApi().getData('pickupPointDistrictList');
    return response['data'];
  }

  Future getUpazillaList(districtId, context) async {
    var data = {'district_id': districtId};
    var response = await CallApi().postData(data, 'upazillaList', context);
    debugPrint(response.toString());
    return response['data'];
  }
}
