import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_chat_icon.g.dart';

@riverpod
class ChatIconStart extends _$ChatIconStart {
  @override
  bool build() => false;

  void updateState() {
    state = true;
  }
}
