import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget floating = Padding(
  padding: EdgeInsets.only(top: 20),
  child: SizedBox(
    height: 70,
    width: 70,
    child: FloatingActionButton(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {},
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 4),
            shape: BoxShape.circle,
            color: Colors.red),
        child: Icon(Icons.add, size: 40),
      ),
    ),
  ),
);
