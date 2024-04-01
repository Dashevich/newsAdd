import '../model/news.dart';

abstract interface class NewsData {
  Future<News> getData(String request);
}