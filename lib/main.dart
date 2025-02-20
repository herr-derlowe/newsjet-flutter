import 'package:flutter/material.dart';
import 'package:newsjet/pages/home_page.dart';
import 'package:newsjet/pages/news_list.dart';
import 'package:newsjet/pages/saved_news.dart';
import 'package:newsjet/widgets/news_drawer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NewsJet App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        ),
        home: AppScaffold());
  }
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  String selectedPage = "home";
  
  void navigateTo(String pageName) {
    setState(() {
      selectedPage = pageName;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    
    switch (selectedPage) {
      case "home":
        currentPage = HomePage();
      case "saved":
        currentPage = SavedNews();
      default:
        currentPage = NewsList(newsEndpoint: selectedPage);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: TextButton(
          onPressed: () => navigateTo("home"), 
          child: Text(
            "NEWSJET",
            style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      drawer: NewsDrawer(navigateTo: navigateTo),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: currentPage,
      )
    );
  }
}
