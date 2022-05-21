import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

showloadingDialog(context){
  showDialog(
    barrierDismissible: false,
  context: context,
  builder: (_) => Material(
    type: MaterialType.transparency,
    child: Center(
      // Aligns the container to center
      child: Container(
        // A simplified version of dialog.
        width: 100.0,
        height: 56.0,
        color: Colors.transparent,
        child: SpinKitThreeInOut(itemBuilder: (BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(right: 3),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: index.isEven ? Colors.red : Colors.green,
        ),
      ),
    );
  },)
      ),
    ),
  ),
); 
}

