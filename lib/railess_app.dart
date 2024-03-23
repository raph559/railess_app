import 'package:flutter/material.dart';
import 'custom_colors.dart';
import 'home_page.dart';
import 'my_app_bar.dart';
import 'my_drawer.dart';
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

  void _onThemeChanged(bool value) {
    setState(() {
      isDark = value;
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
        appBar: _selectedIndex == 0 ? MyAppBar(isDark: isDark) : null,
        drawer: MyDrawer(isDark: isDark, onThemeChanged: _onThemeChanged),
        body: Center(
            child: _selectedIndex == 0 ? HomePage(isDark: isDark, onThemeChanged: _onThemeChanged) : TrainPage(isDark: isDark)
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