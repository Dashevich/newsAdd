import 'package:flut_app/domain/repository/favourite_repository.dart';
import 'package:flut_app/data/model/story.dart';
import 'package:flut_app/data/repository/favourite_repository.dart';


class FavouriteService implements FavouriteRepository{
  final FavouriteData favourite;

  FavouriteService(this.favourite);

  void addItem(Story item) {
    favourite.addItemData(item);
  }

  void deleteItem(Story item) {
    favourite.deleteItemData(item);
  }

  List<Story> getLiked() {
    return favourite.getLikedData();
  }

  void toggleLike(Story item) {
    return favourite.toggleLikeData(item);
  }

  bool isLiked(Story item) {
    return favourite.isLikedData(item);
  }
}