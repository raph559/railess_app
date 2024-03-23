import 'package:flutter/material.dart';

void main() => runApp(const RailessApp());

class CustomColors {
  static const Color background = Color(0xFF808cf1);
}

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
        drawer: MyDrawer(),
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

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Center(
        child: Text('This is the About Page'),
      ),
    );
  }
}

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service'),
      ),
      body: const Center(
        child: Text('This is the Service Page'),
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: const Center(
        child: Text('This is the Help Page'),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: const Center(
        child: Text('This is the Contact Page'),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;

  const MyAppBar({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Railess.',
        style: TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'NotoSansMono',
        ),
      ),
      centerTitle: true,
      backgroundColor: CustomColors.background,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

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

class HomePage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const HomePage({super.key, required this.isDark, required this.onThemeChanged});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  trailing: <Widget>[
                    Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          isSelected: widget.isDark,
                          onPressed: () {
                            setState(() {
                              widget.onThemeChanged(!widget.isDark);
                            });
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          selectedIcon: const Icon(Icons.brightness_2_outlined),
                        )
                    )
                  ],
                ),
              ),
            ],
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(20, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              },
            );
          });
        },
      ),
    );
  }
}
class TrainPage extends StatelessWidget {
  const TrainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Train Page'),
    );
  }
}

class MyBody extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  const MyBody({super.key, required this.isDark, required this.onThemeChanged});

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
    isDark = widget.isDark;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded( // Add this
                child: SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  trailing: <Widget>[
                    Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          isSelected: isDark,
                          onPressed: () {
                            setState(() {
                              isDark = !isDark;
                              widget.onThemeChanged(isDark);
                            });
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          selectedIcon: const Icon(Icons.brightness_2_outlined),
                        )
                    )
                  ],
                ),
              ), // Add this
            ],
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(20, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              },
            );
          });
        },
      ),
    );
  }
}
