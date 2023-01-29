import 'package:flutter/material.dart';

Widget drawerHeader() {
  return DrawerHeader(
    decoration: const BoxDecoration(
      color: Colors.pink,
    ),
    child: Stack(
      children: <Widget>[
        const Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://courierdemo.itscholarbd.com/storage/app/uploads/public/629/775/4bc/6297754bceb2a921797616.png'),
            radius: 50.0,
          ),
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Alec Reynolds',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
   
        Align(
          alignment: Alignment.centerRight + const Alignment(0, .8),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.white,
             onPressed: (){},)

          ),
        ),
      ],
    ),
  );
}
