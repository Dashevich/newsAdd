import 'package:flut_app/core/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/news.dart';
part 'newsProv.g.dart';

@riverpod
class NewsData extends _$NewsData {
  @override
  Future<News> build() async {
    News news =
    await ref.read(newsRepositoryProvider).getData('');
    return news;
  }

  Future<News> updateNews(String request) async {
    News news;
    news = await ref.read(newsRepositoryProvider).getData(request);
    state = AsyncValue.data(news);
    return news;
    // return newNews;
  }
}