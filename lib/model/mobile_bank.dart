class MobileBank {
  static const int PEROSANL = 1;
  static const int MERCHANT = 2;

  int bankId = 0;
  String mobileNumber = '';
  int accountType = 0;

  MobileBank(this.bankId, this.mobileNumber, this.accountType);
  MobileBank.fromJson(Map<String, dynamic> bankMap) {
    bankId = bankMap['bankId'] ?? 0;
    mobileNumber = bankMap['mobileNumber'] ?? '';
    accountType = bankMap['accountType'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'bankId': bankId,
      'mobileNumber': mobileNumber,
      'accountType': accountType
    };
  }
}
