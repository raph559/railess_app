import 'package:flutter/material.dart';
import 'custom_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;

  const MyAppBar({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: isDark ? Colors.black : Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(
        'Railess.',
        style: TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'NotoSansMono',
          color: isDark ? Colors.black : Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: CustomColors.background,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
