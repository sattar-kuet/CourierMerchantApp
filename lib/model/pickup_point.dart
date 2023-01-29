import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PickupPoint {
  int id = 0;
  int districtId = 0;
  int upazillaId = 0;
  String title = '';
  String street = '';

  PickupPoint(
      this.id, this.districtId, this.upazillaId, this.title, this.street);

  PickupPoint.fromJson(Map<String, dynamic> pickupPointMap) {
    id = pickupPointMap['id'] ?? 0;
    districtId = pickupPointMap['districtId'] ?? 0;
    upazillaId = pickupPointMap['upazillaId'] ?? '';
    title = pickupPointMap['title'] ?? '';
    street = pickupPointMap['street'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'districtId': districtId,
      'upazillaId': upazillaId,
      'title': title,
      'street': street
    };
  }

  static Future writeSession(PickupPoint pickupPoint) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('pickupPoint', json.encode(pickupPoint.toJson()));
  }

  static Future<PickupPoint> readSession() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var sessionPickupPoint = localStorage.getString('pickupPoint');
    return sessionPickupPoint != null
        ? PickupPoint.fromJson(json.decode(sessionPickupPoint))
        : PickupPoint(0, 0, 0, '', '');
  }
}
