import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/model/story.dart';
import '../providers/favourites.dart';
import '../widgets/newsList.dart';

class FavouritePage extends ConsumerWidget{
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Story> favorites = ref.watch(favoritesStateProvider).value ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.fav),
      ),
      body: Center(
        child: newsList(favorites as List<Story>),
      ),
    );
  }
}