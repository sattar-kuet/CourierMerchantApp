class Customer {
  int id = 0;
  String name = '';
  String mobile = '';
  String alternativeMobile = '';
  int districtId = 0;
  int upazillaId = 0;
  int areaId = 0;
  String address = '';

  Customer(this.id, this.name, this.mobile, this.alternativeMobile,
      this.districtId, this.upazillaId, this.areaId, this.address);

  Customer.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'] ?? 0;
    name = jsonData['name'] ?? '';
    mobile = jsonData['mobile'] ?? '';
    alternativeMobile = jsonData['alternativeMobile'] ?? '';
    districtId = jsonData['districtId'] ?? 0;
    upazillaId = jsonData['upazillaId'] ?? 0;
    areaId = jsonData['areaId'] ?? 0;
    address = jsonData['address'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'alternativeMobile': alternativeMobile,
      'companyProfileId': districtId,
      'upazillaId': upazillaId,
      'address': address,
    };
  }
}
