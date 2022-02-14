
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/data/news_service.dart';
import 'package:untitled2/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler',
      debugShowCheckedModeBanner: false, //sağ üstteki demo yazısını siler
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Haberler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> articles = [];
  String? urlToImage;

  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Image.network(articles[index].urlToImage!),
                      ListTile(
                        leading: Icon(Icons.arrow_drop_down_circle),
                        title: Text(articles[index].title!),
                        subtitle: Text(articles[index].author!),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            articles[index].description!),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(
                              onPressed: () async {
                                await launch(articles[index].url!);

                              }, child: Text('Habere git')),
                        ],
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
