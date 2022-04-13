import 'package:flutter/material.dart';

Widget drawerHeader() {
  return DrawerHeader(
    decoration: BoxDecoration(
      color: Colors.pink,
    ),
    child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'http://www.bbk.ac.uk/mce/wp-content/uploads/2015/03/8327142885_9b447935ff.jpg'),
            radius: 50.0,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Alec Reynolds',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
   
        Align(
          alignment: Alignment.centerRight + Alignment(0, .8),
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
               onPressed: (){},)
             
            ),
          
          ),
        ),
      ],
    ),
  );
}
