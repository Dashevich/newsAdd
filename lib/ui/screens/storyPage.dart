import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/model/story.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoryPage extends StatelessWidget{
  const StoryPage(this.story, {super.key});
  final Story story;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: story.source.name != null ? Text(story.source.name as String) : const Text("News"),

      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                (story.title).split('|')[0],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              if (story.urlToImage != null)
              Flexible(
                flex: 2,
                child: Image.network(
                  story.urlToImage as String,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return const SizedBox();
                  },
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                story.content,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => launchUrl(Uri.parse(story.url)),
                child: Text(
                  AppLocalizations.of(context)!.browse,
                  style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                ),
              )
            ]
          )
        ),
      ),
    );
  }
}
