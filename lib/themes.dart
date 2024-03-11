import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
  ),
  useMaterial3: true,
);

const sunIcon = Icon(Icons.sunny,);
const moonIcon = Icon(Icons.nightlight,);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;
  Icon _iconData = sunIcon;

  ThemeData get themeData => _themeData;
  Icon get iconData => _iconData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  set iconData(Icon iconData) {
    _iconData = iconData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
      iconData = moonIcon;
    } else {
      themeData = lightTheme;
      iconData = sunIcon;
    }
  }
}