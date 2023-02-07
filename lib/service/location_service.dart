import 'package:flutter_app/model/district.dart';
import 'package:flutter_app/model/pickup_point.dart';
import 'package:flutter_app/model/upazilla.dart';
import 'package:flutter_app/utility/helper.dart';
import '../remote/api.dart';

class LocationService {
  Future<List<District>> getDistrictList() async {
    var response = await CallApi().getData('district/get');
    List<District> districts = [];
    response['result']['data'].forEach((item) {
      District district = District.fromJson(item);
      districts.add(district);
    });
    return districts;
  }

  Future<PickupPoint> getPickupPoint(context) async {
    var data = {
      "params": {
        "uid": Helper.getUserId(),
      }
    };
    var response = await CallApi().postData(data, 'pickup_point/get', context);
    PickupPoint pickupPoint = PickupPoint.fromJson(response['result']['data']);
    return pickupPoint;
  }

  Future<List<Upazilla>> getUpazillaList(districtId, context) async {
    var data = {
      'params': {'district_id': districtId}
    };
    var response = await CallApi().postData(data, 'upazillaList', context);
    List<Upazilla> upazillas = [];
    response['result']['data'].forEach((item) {
      Upazilla upazilla = Upazilla.fromJson(item);
      upazillas.add(upazilla);
    });
    return upazillas;
  }
}
