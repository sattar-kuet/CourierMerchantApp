import 'package:flutter/material.dart';
import '../widget/drawerHeader.dart';
import '../widget/drawerItem.dart';
import '../routes/pageRoute.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          drawerHeader(),
          drawerItem(
            icon: Icons.home,
            text: 'Login',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.login),
          ),
          drawerItem(
            icon: Icons.account_circle,
            text: 'Registration',
            onTap: () => Navigator.pushReplacementNamed(
                context, PageRoutes.registration),
          ),
          Divider(),
          drawerItem(icon: Icons.notifications_active, text: 'Notifications'),
          drawerItem(icon: Icons.contact_phone, text: 'Contact Info'),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
