import 'package:flutter/material.dart';
import 'package:flut_app/data/model/story.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import '../icons/liked.dart';
import '../icons/unliked.dart';
import '../providers/favourites.dart';


class newsCards extends ConsumerWidget {
  Story story;

  newsCards(this.story);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: (story.urlToImage != null) ? 5 : 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (story.source.name != null)
                              Text(story.source.name as String,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 18),
                                softWrap: false,
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Text(story.title.split('|')[0]),
                            ),
                            likeWidget(story),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (story.urlToImage != null)
                Flexible(
                  flex: 2,
                  child: Image.network(
                    story.urlToImage as String,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const SizedBox();
                    },
                    fit: BoxFit.fitHeight,
                  ),
                ),
            ],
          ),
        ),
    );
  }

}

class likeWidget extends ConsumerWidget {
  Story story;
  likeWidget(this.story);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Story> favorites = ref
        .watch(favoritesStateProvider)
        .value ?? [];
    bool favorite = ref.watch(favoritesStateProvider.notifier).isLiked(story, favorites);
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: favorite ? iconLiked : iconUnliked,
            onPressed: () {
              favorite
                  ? ref.read(favoritesStateProvider.notifier).deleteItem(story)
                  : ref.read(favoritesStateProvider.notifier).addItem(story);
              //setState(() => this.listData = data);
              },
          )
        ]
    );
  }
}