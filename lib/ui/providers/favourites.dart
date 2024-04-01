import 'package:flutter/material.dart';
import '../../data/model/story.dart';
import '../icons/liked.dart';
import '../icons/unliked.dart';
import 'package:flut_app/domain/repository/favourite_repository_impl.dart';

import 'package:flut_app/core/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favourites.g.dart';

@riverpod
class FavoritesState extends _$FavoritesState {
  @override
  Future<List<Story>> build() async {
    List<Story> list =
    await ref.read(favoriteRepositoryProvider).getLiked();
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
      ref.read(favoriteRepositoryProvider).addItem(item);
    }
  }

  void deleteItem(Story item) async {
    ref.read(favoriteRepositoryProvider).deleteItem(item);
  }

  bool isLiked(Story item, List<Story> list) {
    bool like = false;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == item) {
        like = true;
      }
    }
    return like;
  }
}
