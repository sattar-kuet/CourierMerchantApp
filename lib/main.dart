import 'package:flutter/material.dart';

void main() => runApp(const CourierApp());

class CourierApp extends StatelessWidget {
  const CourierApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text('custom navigation')),
          backgroundColor: Colors.blueAccent,
          floatingActionButton: Padding(
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
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: new Container(
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
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.bookmark_border,
                        color: Colors.transparent,
                      ),
                      label: 'Center',
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
