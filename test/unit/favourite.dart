import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:flut_app/core/providers.dart';
import 'package:flut_app/data/repository/favourite_repository_impl.dart';
import 'package:flut_app/data/repository/news_repository_impl.dart';
import 'package:flut_app/data/model/story.dart';
import 'package:flut_app/data/model/source.dart';
import 'package:flut_app/ui/app.dart';
import 'package:flut_app/ui/providers/themes.dart';

class MockFavouriteNewsDao extends Mock implements FavouriteDataRepository {}

class MockNewDao extends Mock implements NewsDataRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  late final FavouriteDataRepository favouriteDataRepository;
  late final NewsDataRepository newsDataRepository;

  setUpAll(() {
    favouriteDataRepository = FavouriteDataRepository();
    newsDataRepository = NewsDataRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        favoriteProvider.overrideWithValue(favouriteDataRepository),
        newsProvider.overrideWithValue(newsDataRepository),
      ],
    );

    addTearDown(container.dispose);

    return container;
  }

  test(
    'Проверка получения новостей',
        () async {
      final news = await newsDataRepository.getData('it');
      expect(news.status, 'ok');
      expect(news.articles.length, greaterThan(0));
    },
  );
  test(
    'Проверка удаления новости из ибранного',
        () async {
       var mockNews1 = Story(
        Source(
        'sourceId1',
        'sourceName1',),
        'author1',
        'title1',
        'description1',
        'url1',
        'urlToImage1',
        'publishedAt1',
        'content1',
      );
      var mockNews2 = Story(
          Source('sourceId2',
        'sourceName2',),
        'author2',
        'title2',
        'description2',
        'url2',
        'urlToImage2',
        'publishedAt2',
        'content2',
      );
      favouriteDataRepository
        ..addItemData(mockNews1)
        ..addItemData(mockNews2);
      List<Story> news = await favouriteDataRepository.getLikedData();
      expect(news.length, 2);
      favouriteDataRepository.deleteItemData(mockNews1);
      news = await favouriteDataRepository.getLikedData();
      expect(news.length, 1);
      expect(news[0].title, mockNews2.title);
    },
  );
  //

  ///это тест не проходит, выдает ошибку с которой никак не могу справиться(
  testWidgets('Проверка смены темы', (tester) async {
    final containers = createContainer();
    await mockNetworkImages(
          () async => tester.pumpWidget(
        UncontrolledProviderScope(
          container: containers,
          child: const MyApp(),
        ),
      ),
    );

    final element = tester.element(find.byKey(const Key("theme")));
    final icon = find.byKey(const Key("theme"));
    final container = ProviderScope.containerOf(element);

    await tester.tap(icon);
    await tester.pump();
    expect(
      container.read(themesProvider),
      true,
    );
    await tester.pumpWidget(const Placeholder());
    addTearDown(containers.dispose);
    addTearDown(container.dispose);
  });
}
