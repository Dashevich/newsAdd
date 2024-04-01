import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flut_app/data/repository/favourite_repository.dart';
import 'package:flut_app/data/repository/favourite_repository_impl.dart';
import 'package:flut_app/data/repository/news_repository.dart';
import 'package:flut_app/data/repository/news_repository_impl.dart';
import 'package:flut_app/domain/repository/favourite_repository.dart';
import 'package:flut_app/domain/repository/favourite_repository_impl.dart';
import 'package:uuid/uuid.dart';

import '../domain/repository/news_repository.dart';
import '../domain/repository/news_repository_impl.dart';

final uuidProvider = Provider((ref) => const Uuid());
final favoriteProvider = Provider<FavouriteData>(
      (ref) => FavouriteDataRepository(),
  // (ref) => FavoriteNewsDaoImplTest(),
);

final newsProvider = Provider<NewsData>(
      (ref) => NewsDataRepository(),
);

final favoriteRepositoryProvider = Provider<FavouriteRepository>(
      (ref) => FavouriteService(
    ref.read(favoriteProvider),
  ),
);
final newsRepositoryProvider = Provider<NewsRepository>(
      (ref) => NewsService(
      ref.read(newsProvider)),
);
