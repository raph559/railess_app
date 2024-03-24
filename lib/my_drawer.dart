import 'package:flutter/material.dart';
import 'about_page.dart';
import 'contact_page.dart';
import 'custom_colors.dart';

class MyDrawer extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const MyDrawer({Key? key, required this.isDark, required this.onThemeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: CustomColors.background,
        child: Column(
          children: <Widget>[
            Expanded(
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
            Container( // Use a Container instead of DrawerFooter
              alignment: Alignment.bottomLeft,
              child: IconButton(
                color: isDark ? Colors.black : Colors.white,

                icon: Icon(isDark ? Icons.brightness_2 : Icons.brightness_7
                ),
                onPressed: () => onThemeChanged(!isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}