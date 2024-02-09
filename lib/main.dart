import 'package:chat_test_flutter/constants/app_colors.dart';
import 'package:chat_test_flutter/route/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routeInformationParser: route.routeInformationParser,
      routeInformationProvider: route.routeInformationProvider,
      routerDelegate: route.routerDelegate,
      title: 'We Chat',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(
            color: AppColors.kBlack,
          ),
          titleTextStyle: TextStyle(
            color: AppColors.kBlack,
            fontWeight: FontWeight.normal,
            fontSize: 19,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade400),
        useMaterial3: false,
      ),
      // home: const HomeScreen(),
    );
  }
}
