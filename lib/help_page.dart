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
