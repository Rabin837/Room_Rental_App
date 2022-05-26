import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_rental/page/login_user_product_screen.dart';
import 'package:home_rental/page/addproduct_screen.dart';
import 'package:home_rental/controllers/data_controller.dart';
import 'package:home_rental/screens/login_screen.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppDrawer extends StatelessWidget {
  final DataController controller = Get.find();
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromARGB(240, 71, 147, 0),
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 55),
            Text(
              'Welcome : ${controller.userProfileData['userName']}',
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            FittedBox(
              child: Text(
                'Join Date :${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(controller.userProfileData['joinDate']))} ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 2,
                ),
              ),
            ),
            Divider(color: Colors.white70),
            const SizedBox(height: 30),
            buildMenuItem(
              text: 'Add Room',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'My Room',
              icon: Icons.favorite_border,
              onClicked: () => selectedItem(context, 1),
            ),

            /* const SizedBox(height: 16),
            buildMenuItem(
              text: 'Workflow',
              icon: Icons.workspaces_outline,
              onClicked: () => selectedItem(context, 2), 
            ),*/

            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Updates',
              icon: Icons.update,
              onClicked: () => selectedItem(context, 3),
            ),
            Divider(color: Colors.white70),
            const SizedBox(height: 24),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.account_tree_outlined,
              onClicked: () => selectedItem(context, 4),
            ),

            /*const SizedBox(height: 16),
            buildMenuItem(
              text: 'Notifications',
              icon: Icons.notifications_outlined,
              onClicked: () => selectedItem(context, 5),
            ), */
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddProductScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginUserProductScreen(),
        ));
        break;

      case 4:
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) {
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        //},
        //   ),
        // );
        break;
    }
  }
}
