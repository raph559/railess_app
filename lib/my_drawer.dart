import 'package:flutter/material.dart';
import 'about_page.dart';
import 'body.dart';
import 'contact_page.dart';
import 'custom_colors.dart';
import 'help_page.dart';
import 'home_page.dart';
import 'my_app_bar.dart';
import 'my_drawer.dart';
import 'railess_app.dart';
import 'service_page.dart';
import 'train_page.dart';

class MyDrawer extends StatelessWidget {
  final bool isDark;

  const MyDrawer({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: CustomColors.background,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Railess.',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'NotoSansMono',
                  color: isDark ? Colors.black : Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'About',
                style: TextStyle(
                  color: isDark ? Colors.black : Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Service',
                style: TextStyle(
                  color: isDark ? Colors.black : Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ServicePage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Help',
                style: TextStyle(
                  color: isDark ? Colors.black : Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Contact',
                style: TextStyle(
                  color: isDark ? Colors.black : Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}