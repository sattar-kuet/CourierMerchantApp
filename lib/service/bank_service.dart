import 'package:flutter/material.dart';
import '../model/mobile_bank.dart';
import '../model/user.dart';
import '../model/bank.dart';
import '../remote/api.dart';
import '../constants.dart' as Constents;

class BankService {
  Future<dynamic> getBankList(context) async {
    var response = await CallApi().getData('getBankList');
    var banks = response['data'];
    return banks;
  }

  Future saveBank(dynamic data, BuildContext context) async {
    User user = await User.readSession();
    data['token'] = user.id;
    data['userId'] = user.id;
    var response = await CallApi().postData(data, 'saveBank', context);
    print(response);
    return response['data'];
  }

  Future getBank(BuildContext context) async {
    User user = await User.readSession();
    dynamic data = {};
    data['token'] = user.token;
    data['userId'] = user.id;
    var response = await CallApi().postData(data, 'getBank', context);
    //print(response);
    var bankData = response['data'];
    if (bankData.length == 0) {
      return null;
    }
    if (bankData['bankType'] == Constents.BankAccountType.MOBILE) {
      return MobileBank(bankData['bankId'], bankData['mobileNumber'],
          bankData['accountType'], bankData['bankType']);
    }
    return Bank(
        bankData['bankId'],
        bankData['accountName'],
        bankData['accountNumber'],
        bankData['branchName'],
        bankData['bankType']);
  }

  Future getDeliverySpeedList(
      fromUpazillaId, toUpazillaId, parcelTypeId, context) async {
    User user = await User.readSession();
    var data = {};
    data['fromUpazillaId'] = fromUpazillaId;
    data['toUpazillaId'] = toUpazillaId;
    data['parcelTypeId'] = parcelTypeId;

    data['token'] = user.token;
    data['userId'] = user.id;
    var response = await CallApi().postData(data, 'getDeliverySpeeds', context);
    //print(response);
    return response['data'];
  }
}
