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

class RailessApp extends StatefulWidget {
  const RailessApp({Key? key}) : super(key: key);

  @override
  State<RailessApp> createState() => _RailessAppState();
}

class _RailessAppState extends State<RailessApp> {
  bool isDark = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        backgroundColor: CustomColors.background,
        appBar: MyAppBar(isDark: isDark),
        drawer: MyDrawer(isDark: isDark),
        body: Center(
          child: _selectedIndex == 0 ? HomePage(isDark: isDark, onThemeChanged: (value) {
            setState(() {
              isDark = value;
            });
          }) : TrainPage(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.train),
              label: 'Train',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}