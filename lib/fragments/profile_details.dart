import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {
  static const String routeName = '/profile';
  dynamic responseData;

  ProfileDetails(this.responseData, {Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    // make a profile details page
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
      ),
      // make a list view of profile data
      body: ListView(children: <Widget>[
        ListTile(
          title: Text('Name'),
          subtitle: Text(widget.responseData['user']['name']),
        ),
        ListTile(
          title: Text('Mobile'),
          subtitle: Text(widget.responseData['user']['mobile']),
        ),
      ]),
    );
  }
}
