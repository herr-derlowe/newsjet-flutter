import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:newsjet/models/news_link.dart';
import 'package:newsjet/services/api2news.dart';
import 'package:newsjet/widgets/news_select_dialog.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key, required this.newsEndpoint});
  final String newsEndpoint;

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late Future<List<NewsLink>> futureNews;

  // @override
  // void initState() {
  //   super.initState();
  //   futureNews = fetchNews(widget.newsEndpoint);
  // }

  // @override
  // void didUpdateWidget(covariant NewsList oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   futureNews = fetchNews(widget.newsEndpoint);
  // }
  
  @override
  Widget build(BuildContext context) {
    futureNews = fetchNews(widget.newsEndpoint);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          heightFactor: 3,
          child: Text(
            newsSources.entries
                .firstWhere((element) => element.value == widget.newsEndpoint)
                .key,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),
        FutureBuilder<List<NewsLink>>(
            future: futureNews,
            builder: ((context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData) {
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
                      //print(newsLink.title);
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
                                  isSavedNews: false,
                                  updateNews: () {},
                                );
                              });
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                  ),
                );
            })),
      ],
    );
  }
}
