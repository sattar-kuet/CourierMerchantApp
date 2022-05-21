import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import '../common/menu_drawer.dart';
import '../common/bottom_navigation.dart';
import '../common/floating_button.dart';

class Bank extends StatefulWidget {
  static const String routeName = '/bankPage';

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  final _formKey = GlobalKey<FormState>();
  int bankTypeId = 0;
  List<S2Choice<int>> banks = [];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Bank"),
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: new Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              children: [
                Padding(padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 30.0),
                  child:  SmartSelect<int>.single(
                    placeholder: "কোন ব্যাংক এ টাকা নিতে চান?",
                    modalFilter: true,
                    modalFilterAuto: true,
                    tileBuilder: (context, state) => S2Tile<dynamic>(
                      //https://github.com/akbarpulatov/flutter_awesome_select/blob/master/example/lib/features_single/single_chips.dart
                      title: const Text(
                        'কোন ব্যাংক এ টাকা নিতে চান?',
                      ),
                      value: state.selected?.toWidget() ?? Container(),
                      leading: Icon(Icons.list_outlined),
                      onTap: state.showModal,
                    ),
                    title: 'কোন ব্যাংক এ টাকা নিতে চান?',
                    choiceItems: banks,
                    onChange: (state)async {
                      setState((){ bankTypeId = state.value!;
                      //updateAreaList();
                      });
                    },
                    selectedValue: bankTypeId,
                  ),
                ),
              ],
            )
          ],),
        ),
        ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: floating,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
