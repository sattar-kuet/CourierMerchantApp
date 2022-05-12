import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../fragments/intro_screen.dart';
import '../widget/drawerHeader.dart';
import '../widget/drawerItem.dart';
import '../routes/pageRoute.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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

          Expanded(
            child: Container(),
          ), // this to force the bottom items to the lowest point
          Column(
            children: <Widget>[
              _createFooterItem(
                icon: Icons.logout,
                text: 'Logout',
                onTap: () => _logOut(context),
              ),
              _createFooterItem(
                icon: Icons.code,
                text: 'Developed By: ITscholarBD',
                onTap: () => () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createFooterItem(
      {required IconData icon,
      required String text,
      GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _logOut(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => IntroPage()));
  }
}
