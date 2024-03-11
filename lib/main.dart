import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'structs/news.dart';
import 'structs/story.dart';
import 'pages/storypage.dart';
import 'themes.dart';
import 'langs.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => LangProvider()),
    ],
    child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Provider.of<LangProvider>(context).langData,
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      home: const MyHomePage(title: 'Programmer News',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title,});
  final String title;

    @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<News> itnews, polnews, spnews, edunews;
  String theme = "lite";

  @override
  void initState() {
    super.initState();
    itnews = getData('it');
    polnews = getData('politic');
    spnews = getData('sports');
    edunews = getData('education');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child:Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.name),
        actions: <Widget>[
          IconButton(
            icon: Provider.of<ThemeProvider>(context).iconData,
            tooltip: 'Change theme',
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: 'Change language',
            onPressed: () {
              Provider.of<LangProvider>(context, listen: false).toggleLang();
            },
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
          return newsList(snapshot.data as News);
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

  Widget newsList(News news) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SizedBox(
            height: 620,
          child: ListView(
            children: [
              for(var i = 0; i < news.articles.length; ++i)
                if (news.articles[i].title != '[Removed]')
                AspectRatio(
                  aspectRatio: 1.8,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return StoryPage(news.articles[i]);
                        },
                      ),
                      );
                    },
                    child: newsCard(news.articles[i]),
                  ),
                ),
            ],
          ),
          ),
        ),
      ),
    ],
    );
  }

  Widget newsCard(Story story) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 3,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
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
                      SizedBox(
                        height: 120,
                      child: Text(story.title.split('|')[0]),
                      ),
                    ],
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
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
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
