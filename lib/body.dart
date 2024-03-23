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
