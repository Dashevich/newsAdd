import 'package:flut_app/data/repository/favourite_repository.dart';
import 'package:flut_app/data/model/story.dart';
import 'package:uuid/uuid.dart';

class FavouriteDataRepository implements FavouriteData {
  List<Story> liked = [];

  FavouriteDataRepository() : liked = [];

  @override
  addItemData(Story item) {
    liked.add(item);
  }

  @override
  void toggleLikeData(Story item) {
    final storyIndex = liked.indexOf(item);
    if (storyIndex == -1) {
      addItemData(item);
    } else {
      deleteItemData(item);
    }
  }

  @override
  List<Story> getLikedData() {
    return liked;
  }

  @override
  deleteItemData(Story item) {
    liked.remove(item);
  }

  @override
  bool isLikedData(Story item) {
    return (liked.indexOf(item) == -1);
  }
}