import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:newsjet/models/news_link.dart';
import 'package:newsjet/services/api2news.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key, required this.newsEndpoint});
  final String newsEndpoint;

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late Future<List<NewsLink>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews(widget.newsEndpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          heightFactor: 3,
          child: Text(
              newsSources.entries.firstWhere((element) => element.value==widget.newsEndpoint).key,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.0,
          children: [
            FutureBuilder<List<NewsLink>>(future: futureNews, builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(itemCount: snapshot.data!.length, itemBuilder: (context, index) {
                  NewsLink newsLink = snapshot.data![index];
                  return AnyLinkPreview(
                    link: newsLink.link,
                    displayDirection: UIDirection.uiDirectionHorizontal,
                    showMultimedia: true,
                    errorImage: "https://placehold.co/400x300",
                    onTap: () => ,
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