import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Bank{
  static const int MOBILE_BANK = 1;
  static const int BANK = 0;
  int id = 0;
  String name = '';
  int type = 0;
  Bank(this.id,this.name, this.type);
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

   static Future writeSession(List<Map<int, int>> bank) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('mobileBanks', json.encode(bank.toJson()));
  }

  static Future<dynamic> readSession() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var sessionBank = localStorage.getString('mobileBanks');
    return sessionBank != null
        ? Bank.fromJson(json.decode(sessionBank))
        : new Bank(0, '', 0);
  }

  static Future<int> bankType(int id) async{
    var mobileBanks = await readSession();
    for (var mobileBank in mobileBanks){
       if(mobileBank.id == id){
         return MOBILE_BANK;
       }
    }
    return BANK;
  }
}