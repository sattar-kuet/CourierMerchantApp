import 'package:flutter/material.dart';
import 'package:flutter_app/common/bottom_navigation.dart';
import 'package:flutter_app/common/floating_button.dart';
import 'package:flutter_app/common/home_page.dart';
import 'package:flutter_app/common/menu_drawer.dart';
import 'package:flutter_app/common/more_page.dart';
import 'package:flutter_app/common/person_page.dart';
import 'package:flutter_app/common/search_page.dart';
import 'package:flutter_app/fragments/registration.dart';
import 'package:flutter_app/widget/drawerHeader.dart';

class BottomPage extends StatefulWidget {
  BottomPage({Key? key}) : super(key: key);
  dynamic currentTab = 2;
  Widget currentPage = HomePage();

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  @override
  void initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  void _selectTab(int? tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = widget.currentPage = HomePage();
          break;
        case 1:
          widget.currentPage = SearchPage();
          break;
        case 2:
          widget.currentPage = PersonPage();
          break;
        case 3:
          widget.currentPage = MorePage();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('custom navigation')),
      drawer: MenuDrawer(),
      backgroundColor: Colors.blueAccent,
      floatingActionButton: floating,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: widget.currentPage,
      bottomNavigationBar: Container(
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
              currentIndex: widget.currentTab,
              onTap: (int i) {
                this._selectTab(i);
              },
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
      ),
    );
  }
}
