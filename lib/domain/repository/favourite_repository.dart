import 'package:flut_app/data/model/story.dart';

abstract interface class FavouriteRepository {
  void addItem(Story item);
  void deleteItem(Story item);
  void toggleLike(Story item);
  bool isLiked(Story item);
  List<Story> getLiked();
}
