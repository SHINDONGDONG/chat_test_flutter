import 'package:chat_test_flutter/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

List<String> widgetList = [
  "첫번째입니다",
  "두번째입니다",
  "세번째입니다",
];

class PageviewScreen extends ConsumerWidget {
  const PageviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      animationDuration: const Duration(milliseconds: 300),
      initialIndex: 0,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          padding: const EdgeInsets.all(10),
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.red,
          indicator: const BoxDecoration(),
          onTap: (index) {
            ref.read(currentProvider.notifier).state = index;
          },
          tabs: [
            Tab(
              child: SvgPicture.asset(
                "assets/logo/google_logo.svg",
                colorFilter: ref.watch(currentProvider) == 0
                    ? null
                    : const ColorFilter.mode(
                        Colors.purple,
                        BlendMode.srcIn,
                      ),
              ),
            ),
            const Tab(
              icon: Icon(Icons.settings),
            ),
            const Tab(
              icon: Icon(Icons.accessibility),
            ),
          ],
        ),
        body: TabBarView(
          children: widgetList
              .map((e) => Center(
                    child: Text(e),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
