import 'package:flutter/material.dart';
import '../../data/model/story.dart';
import '../icons/liked.dart';
import '../icons/unliked.dart';

import 'package:flut_app/core/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favourites.g.dart';

@riverpod
class FavoritesState extends _$FavoritesState {
  late List<Story> list;
  @override
  Future<List<Story>> build() async {
    list = await ref.read(favoriteRepositoryProvider).getLiked();
    return list;
  }

  void addItem(Story item) async {
    bool isUnique = true;
    for (int i = 0; i < state.value!.length; i++) {
      if (state.value?[i] == item) {
        isUnique = false;
        break;
      }
    }
    if (isUnique) {
      //list.add(item);
      ref.read(favoriteRepositoryProvider).addItem(item);
    }
  }

  void deleteItem(Story item) async {
    //list.remove(item);
    ref.read(favoriteRepositoryProvider).deleteItem(item);
  }

  void toggleLike(Story item) async {
    ref.read(favoriteRepositoryProvider).toggleLike(item);
    state = AsyncValue.data(ref.read(favoriteRepositoryProvider).getLiked());
  }

  bool isLiked(Story item) {
    bool like = ref.read(favoriteRepositoryProvider).isLiked(item);
    return like;
  }
}
