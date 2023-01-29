import 'package:flutter/material.dart';

Widget drawerItem({
  required IconData icon,
  required String text,
  GestureTapCallback? onTap,
}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
