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
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                  color: isDark ? Colors.white : Colors.black, // Change the color based on the theme
                ),
              ),
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Service'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ServicePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Contact'),
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