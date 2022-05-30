class Parcel {
  int bankId = 0;
  String accountName = '';
  String accountNumber = '';
  String branch = '';
  int bankType = 0;

  Parcel(this.bankId, this.accountName, this.accountNumber, this.branch,
      this.bankType);
  Parcel.fromJson(Map<String, dynamic> bankMap) {
    bankId = bankMap['id'] ?? 0;
    accountName = bankMap['accountName'] ?? '';
    accountNumber = bankMap['accountNumber'] ?? '';
    branch = bankMap['branch'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'bankId': bankId,
      'accountName': accountName,
      'accountNumber': accountNumber,
      'branch': branch
    };
  }
}
