class PickupPoint {
  int id = 0;
  int districtId = 0;
  String district = '';
  int upazillaId = 0;
  String upazilla = '';
  String address = '';
  String lat = '';
  String lng = '';

  PickupPoint(this.id, this.districtId, this.district, this.upazillaId,
      this.upazilla, this.address, this.lat, this.lng);

  PickupPoint.fromJson(Map<String, dynamic> pickupPointMap) {
    id = pickupPointMap['id'] ?? 0;
    districtId = pickupPointMap['districtId'] ?? 0;
    district = pickupPointMap['district'] ?? '';
    upazillaId = pickupPointMap['upazillaId'] ?? 0;
    upazilla = pickupPointMap['upazilla'] ?? '';
    address = pickupPointMap['address'] ?? '';
    lat = pickupPointMap['lat'] ?? '';
    lng = pickupPointMap['lng'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'districtId': districtId,
      'district': district,
      'upazillaId': upazillaId,
      'upazilla': upazilla,
      'address': address,
      'lat': lat,
      'lng': lng,
    };
  }
}
