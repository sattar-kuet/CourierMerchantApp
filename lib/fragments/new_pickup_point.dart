import 'package:flutter/material.dart';

class NewPickupPoint extends StatefulWidget {
  static const String routeName = '/NewPickupPointPage';
  const NewPickupPoint({Key? key}) : super(key: key);

  @override
  State<NewPickupPoint> createState() => _NewPickupPointState();
}

class _NewPickupPointState extends State<NewPickupPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new pickup point'),
      ),
      body: Column(
        children: [
          Container(
            child: Text('List of pickup point'),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                 showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Login'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                icon: Icon(Icons.account_box),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Message',
                                icon: Icon(Icons.message ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                     actions: [
                      ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () {
                            // your code
                          })
                    ],
                  );
                });
              },
              child: Icon(Icons.plus_one),
            ),
          ),
        ],
      ),
    );
  }
}
