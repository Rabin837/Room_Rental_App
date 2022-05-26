import 'package:flutter/material.dart';
import 'package:home_rental/Screens/Templates/AccountPage.dart';
import 'package:home_rental/Screens/Templates/NotificationsPage.dart';
import 'package:home_rental/screens/home_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'rooms_maps.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  GlobalKey _NavKey = GlobalKey();

  var PagesAll = [
    HomeScreen(),
    UserRoomMarker(),
    NotificationPage(),
    Accountpage()
  ];

  var myindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        key: _NavKey,
        items: [
          Icon((myindex == 0) ? Icons.home_outlined : Icons.home),
          IconButton(
            icon: Icon(
              (myindex == 1)
                  ? Icons.location_on_sharp
                  : Icons.location_on_outlined,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserRoomMarker()),
              );
            },
          ),
          Icon((myindex == 2)
              ? Icons.notifications_active_rounded
              : Icons.notifications_active_outlined),
          Icon((myindex == 3)
              ? Icons.perm_identity
              : Icons.account_circle_sharp),
        ],
        buttonBackgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
        animationCurve: Curves.fastLinearToSlowEaseIn,
        color: Colors.orange,
      ),
      body: PagesAll[myindex],
    );
  }
}
