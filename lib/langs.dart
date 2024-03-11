import 'package:flutter/material.dart';

const engLang = Locale('en');
const rusLang = Locale('ru');

class LangProvider with ChangeNotifier {
  Locale _langData = engLang;

  Locale get langData => _langData;

  set langData(Locale langData) {
    _langData = langData;
    notifyListeners();
  }

  void toggleLang() {
    if (_langData == engLang) {
      langData = rusLang;
    } else {
      langData = engLang;
    }
  }
}