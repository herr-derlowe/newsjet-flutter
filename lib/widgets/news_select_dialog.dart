import 'package:flutter/material.dart';
import 'package:newsjet/models/news_link.dart';
import 'package:newsjet/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsSelectDialog extends StatelessWidget {
  const NewsSelectDialog({super.key, required this.newsLink, required this.isSavedNews, required this.updateNews});
  final Function() updateNews;
  final NewsLink newsLink;
  final bool isSavedNews;

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(newsLink.link))) {
      throw Exception('Could not launch ${newsLink.link}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("News article selection"),
      content: Text("What do you wish to do?"),
      insetPadding: EdgeInsets.all(10.0),
      actions: [
        TextButton(onPressed: _launchUrl, child: Text("Visit link")),
        if (isSavedNews)
          TextButton(
            onPressed: () {
              final DatabaseService databaseService = DatabaseService.instance;
              try {
                databaseService.deleteNewsLink(newsLink.id!);
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Article link removed")));

                updateNews();
              } on Exception catch (e) {
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Couldn't remove article link")));
                print("Error occurred: $e");
              }
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Text("Remove article"))
        else
          TextButton(
            onPressed: () async {
              final DatabaseService databaseService = DatabaseService.instance;
              
              NewsLink? article = await databaseService.getSingleNewsLink(newsLink.link);
              if (article == null) {
                databaseService.insertNewsLink(newsLink);
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved article")));
                print("Saved article: ${newsLink.title}");
              } else {
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Article already saved")));
              }
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Text("Save article")),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Go back"),
        )
      ],
    );
  }
}
