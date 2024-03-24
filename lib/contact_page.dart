import 'package:flutter/material.dart';
import 'custom_colors.dart';

class ContactPage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const ContactPage({super.key, required this.isDark, required this.onThemeChanged});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: CustomColors.background,
        iconTheme: IconThemeData(
          color: widget.isDark ? Colors.black : Colors.white, // change your color here
        ),
        title: Text('Contact',
          style: TextStyle(
            fontSize: 30,
            color: (widget.isDark ? Colors.black : Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Text(
                "You can reach us via:\n"
                "Email: contact@mathisbukowski.fr\n",
              style: TextStyle( fontSize: 20.0, color: (widget.isDark ? Colors.black : Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}