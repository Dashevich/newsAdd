import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'langs.g.dart';

@riverpod
class Lang extends _$Lang {
  @override
  Locale build() {
    return const Locale('en');
  }

  void setLocale({required Locale locale}) {
    state = locale;
  }
}
