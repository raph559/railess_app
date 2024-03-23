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
    return const Column(
      children: [
        Text("Home Page here!"),
      ],
    );
  }
}
