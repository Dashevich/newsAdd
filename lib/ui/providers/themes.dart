import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'themes.g.dart';

@riverpod
class Themes extends _$Themes {
  @override
  bool build() {
    return false;
  }

  void changeTheme() {
    state = !state;
  }
}
