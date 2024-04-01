import 'package:flutter/material.dart';
import 'package:flut_app/data/model/news.dart';
import 'package:flut_app/data/model/story.dart';
import 'package:flut_app/domain/repository/news_repository_impl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';


import '../../core/providers.dart';
import 'favouritePage.dart';
import '../providers/langs.dart';
import '../widgets/newsList.dart';
import '../providers/themes.dart';
import '../providers/newsProv.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title,});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  late Future<News> itnews, polnews, spnews, edunews;
  String theme = "lite";

  late final NewsService newsService;

  @override
  void initState() {
    super.initState();
    itnews = ref.read(newsDataProvider.notifier).updateNews('it');
    polnews = ref.read(newsDataProvider.notifier).updateNews('politic');
    spnews = ref.read(newsDataProvider.notifier).updateNews('sports');
    edunews = ref.read(newsDataProvider.notifier).updateNews('education');

  }

  @override
  Widget build(BuildContext context) {
    Locale locale = ref.watch(langProvider);
    bool theme = ref.watch(themesProvider);
    return DefaultTabController(
      length: 4,
      child:Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(AppLocalizations.of(context)!.name),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.favorite_border),
              tooltip: 'See favourites',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return FavouritePage();
                  },
                ),
                );
              },
            ),
            IconButton(
              icon: theme ? const Icon(Icons.nightlight) : const Icon(Icons.sunny),
              tooltip: 'Change theme',
              onPressed: () {
                ref.read(themesProvider.notifier).changeTheme();              },
            ),
            IconButton(
              icon: const Icon(Icons.language),
              tooltip: 'Change language',
              onPressed: () {
                ref.read(langProvider.notifier).setLocale(
                  locale: Locale((locale.languageCode == 'en') ? 'ru' : 'en'),
                );              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('it')),
              Tab(child: Text('politics')),
              Tab(child: Text('sports')),
              Tab(child: Text('education')),
            ],
          ),
        ),
        body: TabBarView(
            children: [
              Container(
                child: futureWidget(itnews),
              ),
              Container(
                child: futureWidget(polnews),
              ),
              Container(
                child: futureWidget(spnews),
              ),
              Container(
                child: futureWidget(edunews),
              ),
            ]
        ),
      ),
    );
  }

  Widget futureWidget(Future<News> news) {
    return FutureBuilder(
      future: news,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return newsList(snapshot.data?.articles as List<Story>);
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
        return
          const Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

}
