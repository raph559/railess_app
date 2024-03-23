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

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;

  const MyAppBar({Key? key, required this.isDark}) : super(key: key);

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