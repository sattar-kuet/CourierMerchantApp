class Bank {
  static const int MOBILE_BANK = 1;
  static const int BANK = 0;
  static const int PEROSANL = 1;
  static const int MERCHANT = 2;
  int id = 0;
  String name = '';
  int type = 0;
  Bank(this.id, this.name, this.type);
  Bank.fromJson(Map<String, dynamic> bankMap) {
    id = bankMap['id'] ?? 0;
    name = bankMap['name'] ?? '';
    type = bankMap['type'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }
}
