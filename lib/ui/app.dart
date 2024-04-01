import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'providers/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/langs.dart';
import 'package:flut_app/ui/screens/homePage.dart';
import 'themes/darkTheme.dart';
import 'themes/lightTheme.dart';

class MyApp extends ConsumerWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter News App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(themesProvider) ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: ref.watch(langProvider),
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      home: const MyHomePage(title: 'Programmer News',),
    );
  }
}
