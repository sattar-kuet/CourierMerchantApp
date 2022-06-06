class Order {
  int id = 0;
  String customerName = '';
  String customerMobile = '';
  String customerAlternativeMobile = '';
  int customerDistrictId = 0;
  int customerUpazillaId = 0;
  int customerAreaId = 0;
  String customerAddress = '';
  String customerLat = '';
  String customerLong = '';

  int merchantId = 0;
  int pikcupPointDistrictId = 0;
  int pikcupPointUpazillaId = 0;
  String pikcupPointAddress = '';
  String pikcupPointLat = '';
  String pikcupPointLong = '';

  int parcelTypeId = 0;
  double parceActualValue = 0;
  double parceActualWeight = 0;

  int deliverySpeed = 0;
  double cashCollection = 0;
  double deliveryCharge = 0;
  double codCharge = 0;
  String merchantReferenceNumber = '';
  String note = '';

  int activeHubId = 0;
  int transferredHubId = 0;

  int deliveryType = 0;
  bool hasExhange = false;

  int pickupBy = 0;
  int deliverBy = 0;
  int returnBy = 0;

  DateTime rescheduleAt = 0 as DateTime;
  DateTime createdAt = 0 as DateTime;
  DateTime updatedAt = 0 as DateTime;
  DateTime deliveredAt = 0 as DateTime;

  int status = 0;

  Order(
    this.id,
    this.customerName,
    this.customerMobile,
    this.customerAlternativeMobile,
    this.customerDistrictId,
    this.customerUpazillaId,
    this.customerAreaId,
    this.customerLat,
    this.customerLong,
    this.customerAddress,
    this.merchantId,
    this.pikcupPointDistrictId,
    this.pikcupPointUpazillaId,
    this.pikcupPointAddress,
    this.pikcupPointLat,
    this.pikcupPointLong,
    this.parcelTypeId,
    this.parceActualValue,
    this.parceActualWeight,
    this.deliverySpeed,
    this.cashCollection,
    this.deliveryCharge,
    this.codCharge,
    this.merchantReferenceNumber,
    this.note,
    this.activeHubId,
    this.transferredHubId,
    this.deliveryType,
    this.hasExhange,
    this.pickupBy,
    this.deliverBy,
    this.returnBy,
    this.rescheduleAt,
    this.createdAt,
    this.updatedAt,
    this.deliveredAt,
    this.status,
  );
}
