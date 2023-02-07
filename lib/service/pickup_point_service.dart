import 'package:flutter/material.dart';
import '../fragments/new_pickup_point.dart';
import '../remote/api.dart';
import '../utility/helper.dart';

class PickupPointService {
  Future savePickupPoint(
      int district, int upazilla, String address, context) async {
    var data = {
      'params': {
        'user_id': Helper.getUserId(),
        'district_id': district,
        'upazilla_id': upazilla,
        'address': address
      }
    };
    var response =
        await CallApi().postData(data, 'pickup_point/add_or_update', context);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const NewPickupPoint()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response['message']),
      duration: const Duration(seconds: 2),
    ));
  }
}
