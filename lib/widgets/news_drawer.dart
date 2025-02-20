import 'package:flutter/material.dart';
import 'package:newsjet/services/api2news.dart';

class NewsDrawer extends StatelessWidget {
  const NewsDrawer({super.key, required this.navigateTo});
  final Function(String pageName) navigateTo;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Center(
                child: Text(
              "News Sources",
              style: Theme.of(context).textTheme.headlineLarge,
            )),
          ),
          ListTile(
            title: Text('Saved news',
                style: Theme.of(context).textTheme.headlineSmall),
            onTap: () {
              navigateTo("saved");
              Navigator.of(context).pop();
            },
          ),
          Divider(
            height: 100,
            thickness: 10,
            indent: 15,
            endIndent: 15,
          ),
          for (MapEntry<String, String> outletName in newsSources.entries)
            ListTile(
              title: Text(outletName.key, style: Theme.of(context).textTheme.headlineSmall,),
              onTap: () {
                navigateTo(outletName.value);
                Navigator.of(context).pop();
              },
            )
        ],
      ),
    );
  }
}
