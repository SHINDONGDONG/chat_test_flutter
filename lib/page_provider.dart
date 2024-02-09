import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class PageCont extends StateNotifier<PageController> {
  PageCont() : super(PageController());

  void setState(int index) {
    state = PageController(initialPage: index);
  }
}

final pageProvider = StateNotifierProvider<PageCont, PageController>((ref) {
  return PageCont();
});

final currentProvider = StateProvider<int>((ref) {
  return 0;
});
