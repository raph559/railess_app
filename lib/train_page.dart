import 'package:application_jam/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class TrainPage extends StatefulWidget {
  final bool isDark;

  const TrainPage({Key? key, required this.isDark}) : super(key: key);

  @override
  _TrainPageState createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.background,
        appBar: AppBar(
          backgroundColor: CustomColors.background,
          title: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return Center( // Add this
                child: SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ); // And this
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(20, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                      FocusScope.of(context).unfocus();
                    });
                  },
                );
              });
            },
          ),
        ),
        body: Center(
          child: ListView(
            children: const [
              Card(
                margin: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 0),
                child: ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text("TEST"),
                  subtitle: Text("je suis juste un test qui teste de la testation"),
                  trailing: Icon(Icons.track_changes),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text("TEST"),
                  subtitle: Text("je suis juste un test qui teste de la testation"),
                  trailing: Icon(Icons.track_changes),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}