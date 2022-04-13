import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
          height: 80.0,
          color: Colors.white,
          padding: new EdgeInsets.only(top: 20.0),
          child: new Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Colors.white,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Colors.red,
                bottomAppBarColor: Colors.green,
                textTheme: Theme.of(context).textTheme.copyWith(
                    caption: new TextStyle(
                        color: Colors
                            .grey))), // sets the inactive color of the `BottomNavigationBar`
            child: new BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: 0,
                items: [
                  BottomNavigationBarItem(
                      icon: new Icon(Icons.home),
                      label: 'Home',
                      backgroundColor: Colors.black),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.bookmark_border,
                      color: Colors.transparent,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.perm_identity), label: 'Person'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.more_horiz), label: 'More'),
                ]),
          ),
        );
  }
}