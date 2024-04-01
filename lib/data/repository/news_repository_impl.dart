import 'package:flut_app/data/model/news.dart';
import 'package:flut_app/data/repository/news_repository.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewsDataRepository implements NewsData {
  NewsDataRepository();

  @override
  Future<News> getData(String request) async {
    String? apiKey = dotenv.env['API_KEY'];
    String url = 'https://newsapi.org/v2/everything?q=$request&sortBy=publishedAt&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final newsJson = jsonDecode(response.body);
      return News.fromJson(newsJson as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load data');
    }
  }

}
