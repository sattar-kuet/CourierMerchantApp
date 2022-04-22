import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

import '../widget/TextInput.dart';

class RegistrationPage extends StatefulWidget {
  static const String routeName = '/registrationPage';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameInput = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController productTypeId = TextEditingController();
  String? selectedValueSingleDialog;
  List<DropdownMenuItem> items = [];
  TextFormField? input;
  String inputString = "";
  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  
  @override
  void initState() {
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }
    });
    input = TextFormField(
      validator: (value) {
        return ((value?.length ?? 0) < 6
            ? "must be at least 6 characters long"
            : null);
      },
      initialValue: inputString,
      onChanged: (value) {
        inputString = value;
      },
      autofocus: true,
    );
    print(">>>>>>items: " + wordPair.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> widgets;
    widgets = {
      "আপনার প্রোডাক্ট টাইপ ": SearchChoices.single(
        items: items,
        value: selectedValueSingleDialog,
        hint: "সিলেক্ট করুন",
        searchHint: "Select one",
        onChanged: (value) {
          setState(() {
            selectedValueSingleDialog = value;
            print(">>>>>selectedValueSingleDialog: $selectedValueSingleDialog");
          });
        },
        isExpanded: true,
      ),
    };
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            new Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(bottom: 50),
                      child: Image(image: AssetImage('assets/logo.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30.0),
                      child: TextInput(
                        inputController: nameInput,
                        label: 'আপনার নাম',
                        icon: Icons.account_box_sharp,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30.0),
                      child: TextInput(
                        inputController: nameInput,
                        label: 'আপনার বিজনেস এর নাম',
                        icon: Icons.business_center,
                      ),
                    ),
                  ]),
            ),
            Column(
              children: widgets
                  .map((k, v) {
                    return (MapEntry(
                        k,
                        Center(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                margin: EdgeInsets.all(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text("$k:"),
                                      v,
                                    ],
                                  ),
                                )))));
                  })
                  .values
                  .toList()
                ..add(
                  Center(
                    child: SizedBox(
                      height: 1,
                    ),
                  ),
                ), //prevents scrolling issues at the end of the list of Widgets
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _register(context);
                }
              },
              child: Text('Next'),
            )
          ],
        ),
      ),
      // body: new Form(
      //   key: _formKey,
      //   autovalidateMode: AutovalidateMode.onUserInteraction,
      //   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //     Container(
      //       height: 70,
      //       margin: EdgeInsets.only(bottom: 50),
      //       child: Image(image: AssetImage('assets/logo.png')),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
      //       child: TextInput(
      //         inputController: nameInput,
      //         label: 'আপনার নাম',
      //         icon: Icons.account_box_sharp,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
      //       child: TextInput(
      //         inputController: nameInput,
      //         label: 'আপনার বিজনেস এর নাম',
      //         icon: Icons.business_center,
      //       ),
      //     ),

      //     ElevatedButton(
      //       onPressed: () {
      //         if (_formKey.currentState!.validate()) {
      //           _register(context);
      //         }
      //       },
      //       child: Text('Next'),
      //     )
      //   ]),
      // ),
    );
  }

  void _register(BuildContext context) {}
}
