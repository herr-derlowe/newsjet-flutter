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

  // @override
  // void initState() {
  //   super.initState();
  //   futureNewsDatabase = _databaseService.getAllNewsLinks();
  // }

  void updateNews() {
    setState(() {
      futureNewsDatabase = _databaseService.getAllNewsLinks();
    });
  }

  @override
  Widget build(BuildContext context) {
    futureNewsDatabase = _databaseService.getAllNewsLinks();
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          heightFactor: 3,
          child: Text(
            "These are your saved news articles",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),
        FutureBuilder<List<NewsLink>>(
            future: futureNewsDatabase,
            builder: ((context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text("NO NEWS TO SHOW",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary));
              }
              
              if (snapshot.hasError) {
                return Text("ERROR: NO NEWS TO SHOW",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error));
              }

              return Expanded(
                  child: ListView.separated(
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
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
                                return NewsSelectDialog(
                                  newsLink: newsLink,
                                  isSavedNews: true,
                                  updateNews: updateNews,
                                );
                              });
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.0,
                    ),
                  ),
                );
            })),
      ],
    );
  }
}
