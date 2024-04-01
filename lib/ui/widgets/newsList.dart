import 'package:flutter/material.dart';
import 'package:flut_app/data/model/story.dart';
import '../screens/storyPage.dart';
import 'cards.dart';

class newsList extends StatelessWidget {
  List<Story> news;

  newsList(this.news);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: ListView(
              children: [
                for(var i = 0; i < news.length; ++i)
                  if (news[i].title != '[Removed]')
                    AspectRatio(
                      aspectRatio: 1.8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) {
                              return StoryPage(news[i]);
                            },
                          ),
                          );
                        },
                        child: newsCards(news[i]),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}