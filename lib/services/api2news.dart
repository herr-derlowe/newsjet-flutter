import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsjet/models/news_link.dart';

const String apiUrl = "https://endpoint.api2.news/";
const Map<String, String> newsSources = {
  "BBC News": "bbc",
  "Times Of India News": "toi",
  "TechCrunch Newsletter": "techcrunch",
  "New York Times News": "nyt",
  "CNN News": "cnn",
  //"Google News": "google-news",
  //"Wall Street Journal News": "wsj",
  "ABC News": "abcnews",
  "Arstechnica News": "arstechnica",
  "Business Insider News": "businessinsider",
  "Bloomberg News": "bloomberg",
  "Buzzfeed": "buzzfeed",
  "CBC News": "cbc-ca",
  "CBS News": "cbs",
  "Engadget News": "engadget",
  "Mashable News": "mashable",
  "NBC News": "nbcnews",
  "News24": "news24",
  "Washington Post News": "washingtonpost",
  "Wired News": "wired",
  "Times News": "time",
  "Yahoo News": "yahoo-news"
};

Future<List<NewsLink>> fetchNews(String endpointName) async {
  final response = await http.get(Uri.parse(apiUrl + endpointName));
  
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return (jsonDecode(response.body) as List).map((data) => NewsLink.fromJson(data)).toList();
    //return NewsLink.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load news articles');
  }
}