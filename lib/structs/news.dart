import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'story.dart';
part 'news.g.dart';

@JsonSerializable()
class News {
  final String status;
  final int totalResults;
  final List<Story> articles;
  News(
      this.status,
      this.totalResults,
      this.articles,
      );
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

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