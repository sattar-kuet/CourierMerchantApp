import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/button.dart';
import '../common/menu_drawer.dart';
import '../common/bottom_navigation.dart';
import '../common/floating_button.dart';
import '../data/service.dart';
import '../form_components/numberInput.dart';
import '../form_components/textInput.dart';
import '../model/bank.dart';
import '../model/mobile_bank.dart';

class BankScreen extends StatefulWidget {
  static const String routeName = '/bankPage';

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountBranchController = TextEditingController();
  static const MOBILE_BANK = 1;
  static const BANK = 0;
  int bankId = 0;
  int bankType = -1;
  bool bankListLoadingDone = false;
  List<S2Choice<int>> banks = [];
  Map<int, int> mobileBanksHashTable = {};
  int mobileBankAccountType = 0;
  Bank bank = new Bank(0, '', '', '');
  MobileBank mobileBank = new MobileBank(0, '', 0);
  void initState() {
    super.initState();
    Service().getBankList(context).then((_bankList) {
      for (var i = 0; i < _bankList.length; i++) {
        int id = _bankList[i]['id'];
        String name = _bankList[i]['name'];
        int type = _bankList[i]['type'];
        setState(() {
          banks.add(S2Choice<int>(value: id, title: name));
          mobileBanksHashTable[id] = type;
        });
      }
    });
    Service().getBank(context).then((response) {
      setState(() {
        bank = response;
        accountNameController.text = bank.accountName;
        accountNumberController.text = bank.accountNumber;
        accountBranchController.text = bank.branch;
        bankType = 0;
        bankId = bank.bankId;
        bankListLoadingDone = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return new Scaffold(
      appBar: AppBar(
        title: Text("Bank"),
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: new Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  bankListLoadingDone ? selectMethod() : Container(),
                  bankType != -1 ? showDetail() : Container(),
                  bankType != -1
                      ? CustumButtom(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _saveBank(context);
                            }
                          },
                          text: 'Save',
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: floating(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Padding selectMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      child: SmartSelect<int>.single(
        placeholder: "নির্বাচন করুন",
        modalFilter: true,
        modalFilterAuto: true,
        tileBuilder: (context, state) => S2Tile<dynamic>(
          //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
          title: const Text(
            'কোন ব্যাংক এ টাকা নিতে চান?',
          ),
          value: state.selected?.toWidget() ?? Container(),
          onTap: state.showModal,
        ),
        title: 'কোন ব্যাংক এ টাকা নিতে চান?',
        choiceItems: banks,
        onChange: (state) async {
          setState(() {
            bankId = state.value!;
            bankType = mobileBanksHashTable[bankId] as int;
          });
        },
        selectedValue: bankId,
      ),
    );
  }

  dynamic showDetail() {
    return bankType == MOBILE_BANK ? mobileBanking() : normalBanking();
  }

  Container mobileBanking() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20.0,
            ),
            child: numberInput(
              label: "মোবাইল নাম্বার",
              inputController: mobileNumberController,
              inputIcon: Icon(Icons.phone),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        value: MobileBank.PEROSANL,
                        groupValue: mobileBankAccountType,
                        onChanged: (value) {
                          setState(() {
                            mobileBankAccountType = value as int;
                          });
                        },
                      ),
                      Expanded(
                        child: Text('Personal'),
                      )
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        value: MobileBank.MERCHANT,
                        groupValue: mobileBankAccountType,
                        onChanged: (value) {
                          setState(() {
                            mobileBankAccountType = value as int;
                          });
                        },
                      ),
                      Expanded(
                        child: Text('Merchant'),
                      )
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container normalBanking() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            child: textInput(
              label: "একাউন্ট এর নাম",
              inputController: accountNameController,
              inputIcon: Icon(Icons.verified_user),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            child: numberInput(
              label: "একাউন্ট নাম্বার",
              inputController: accountNumberController,
              inputIcon: Icon(Icons.cases_sharp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            child: textInput(
              label: "ব্রাঞ্চ এর নাম",
              inputController: accountBranchController,
              inputIcon: Icon(Icons.anchor),
            ),
          ),
        ],
      ),
    );
  }

  void _saveBank(BuildContext context) {
    var data = {};
    switch (bankType) {
      case MOBILE_BANK:
        data['bank'] = {
          'bank_id': bankId,
          'mobile_number': mobileNumberController.text,
          'account_type': mobileBankAccountType,
        };
        break;
      case BANK:
        data['bank'] = {
          'bank_id': bankId,
          'account_name': accountNameController.text,
          'account_number': accountNumberController.text,
          'branch_name': accountBranchController.text,
        };
        break;
    }
    //print(data);
    Service().saveBank(data, context);
  }
}
