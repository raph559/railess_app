import 'package:flutter/material.dart';
import 'custom_colors.dart';
import 'my_app_bar.dart';

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