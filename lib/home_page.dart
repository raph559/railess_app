import 'package:flutter/material.dart';

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
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 20.0),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg-home.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  height: isPortrait ? 250.0 : 500.0,
                  width: constraints.maxWidth,
                ),
              ),
              Container(
                height: 400,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: isPortrait ? 1.0 : 2.0,
                  children: [
                    _buildCard(Icons.people, 'User SaaS', 'A service created by users for users.'),
                    _buildCard(Icons.timer, 'Saving Time', 'With Railess, you can earn a lot on your train searches.'),
                    _buildCard(Icons.support_agent, 'Reactive Support', 'Our support service is very fast and efficient.'),
                    _buildCard(Icons.bug_report, 'Beta Version', 'Our service is brand new, there may be some unknown bugs. Get closer to the support if necessary.'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Card _buildCard(IconData icon, String title, String description) {
    return Card(
      child: Column(
        children: [
          Icon(icon, size: 50),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}