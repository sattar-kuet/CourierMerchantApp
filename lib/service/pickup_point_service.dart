import 'package:flutter/material.dart';
import 'package:flutter_app/model/pickup_point.dart';
import '../model/user.dart';
import '../fragments/new_pickup_point.dart';
import '../remote/api.dart';

class PickupPointService {
  Future<PickupPoint> getPickupPointObjectFromJson(pickupPointJson) async {
    PickupPoint pickupPoint = PickupPoint(
        pickupPointJson['id'],
        pickupPointJson['districtId'],
        pickupPointJson['upazillaId'],
        pickupPointJson['title'],
        pickupPointJson['street']);
    return pickupPoint;
  }

  Future getPickupAddress(context) async {
    User user = await User.readSession();
    var data = {"user_id": user.id};
    var response = await CallApi().postData(data, 'getPickupAddress', context);
    return response['data'];
  }

  Future<dynamic> savePickupPoint(
      String title, int district, int upazilla, String street, context) async {
    User user = await User.readSession();
    var data = {
      'user_id': user.id,
      'token': user.token,
      'pickupPoint': {
        'title': title,
        'districtId': district,
        'upazillaId': upazilla,
        'street': street
      },
    };
    var response = await CallApi().postData(data, 'savePickupPoint', context);
    PickupPoint pickupPoint =
        await getPickupPointObjectFromJson(response['pickupPoint']);
    PickupPoint.writeSession(pickupPoint);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const NewPickupPoint()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response['message']),
      duration: const Duration(seconds: 2),
    ));
    return response['data'];
  }
}
