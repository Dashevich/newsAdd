import 'package:flut_app/domain/repository/news_repository.dart';
import 'package:flut_app/data/model/news.dart';
import 'package:flut_app/data/repository/news_repository.dart';


class NewsService implements NewsRepository {
  final NewsData newsServ;

  NewsService(this.newsServ);

  @override
  Future<News> getData(String request) async {
    News data = await newsServ.getData(request);
    return data;
  }
}