class Bank {
  int bankId = 0;
  String accountName = '';
  String accountNumber = '';
  String branch = '';
  Bank(this.bankId, this.accountName, this.accountNumber, this.branch);
  Bank.fromJson(Map<String, dynamic> bankMap) {
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
