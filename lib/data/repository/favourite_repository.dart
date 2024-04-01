import 'package:flut_app/data/model/story.dart';

abstract interface class FavouriteData {

  void addItemData(Story item);

  void toggleLikeData(Story item);

  List<Story> getLikedData();

  void deleteItemData(Story item);

  bool isLikedData(Story item);
}