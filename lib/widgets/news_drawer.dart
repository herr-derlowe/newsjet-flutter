import 'package:flutter/material.dart';

class NewsDrawer extends StatelessWidget {
  const NewsDrawer({super.key});

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
              child: Text("News Sources", style: Theme.of(context).textTheme.headlineLarge,)
            ),
          ),
          ListTile(
            title: Text('Item 1', style: Theme.of(context).textTheme.headlineSmall),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
