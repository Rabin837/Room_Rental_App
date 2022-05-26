import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image(
        height: 200,
        width: 200,
        image: AssetImage('asset/images/comingSoon.png'),
      ),
    ));
  }
}
