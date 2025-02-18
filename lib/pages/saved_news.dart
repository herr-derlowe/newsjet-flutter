import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:newsjet/models/news_link.dart';
import 'package:newsjet/services/database.dart';
import 'package:newsjet/widgets/news_select_dialog.dart';

class SavedNews extends StatefulWidget {
  const SavedNews({super.key});

  @override
  State<SavedNews> createState() => _SavedNewsState();
}

class _SavedNewsState extends State<SavedNews> {
  late Future<List<NewsLink>> futureNewsDatabase;
  final DatabaseService _databaseService = DatabaseService.instance;
  

  @override
  void initState() {
    super.initState();
    futureNewsDatabase = _databaseService.getAllNewsLinks();
  }
  void updateNews() {
    setState(() {
      futureNewsDatabase = _databaseService.getAllNewsLinks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          heightFactor: 3,
          child: Text(
              "These are your saved news articles",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.0,
          children: [
            FutureBuilder<List<NewsLink>>(future: futureNewsDatabase, builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(itemCount: snapshot.data!.length, itemBuilder: (context, index) {
                  NewsLink newsLink = snapshot.data![index];
                  return AnyLinkPreview(
                    link: newsLink.link,
                    displayDirection: UIDirection.uiDirectionHorizontal,
                    showMultimedia: true,
                    errorImage: "https://placehold.co/400x300",
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return NewsSelectDialog(newsLink: newsLink, isSavedNews: true, updateNews: updateNews,);
                        }
                      );
                    },
                  );
                });
              } else if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ERROR: NO NEWS TO SHOW", style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],
                );
              }
        
              return CircularProgressIndicator();
            }))
          ],
        ),
      ],
    );
  }
}