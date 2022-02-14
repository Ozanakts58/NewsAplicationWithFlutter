import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled2/models/article.dart';
import 'package:untitled2/models/news.dart';


class NewsService {
  static NewsService singleton = NewsService._internal();
  NewsService._internal();

  factory NewsService(){
    return singleton;
  }
  static Future<List<Articles>?> getNews() async {
    var url = Uri.parse("https://newsapi.org/v2/top-headlines?country=tr&apiKey=***********************************");

    final response = await http.get(url);

    if(response.body.isNotEmpty){
      final responseJson = json.decode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null;
  }
}
