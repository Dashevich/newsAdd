import 'package:flut_app/data/model/news.dart';

abstract interface class NewsRepository {
  Future<News> getData(String request);
}