import 'package:flutter/material.dart';
import 'package:flutter_app/fragments/new_parcel_screen.dart';

Widget floating(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewParcelPage(),
          ),
        ),
        child: Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              shape: BoxShape.circle,
              color: Colors.red),
          child: const Icon(Icons.add, size: 40),
        ),
      ),
    ),
  );
}
