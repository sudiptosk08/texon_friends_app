import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_app/constant/logger.dart';
import 'package:friends_app/constant/navigation_service.dart';
import 'package:friends_app/network_utils/network_utils.dart';
import 'package:friends_app/scr/features/friendList_screen/controller/get_friendList_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';

import 'scr/features/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initialize();
  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
   @override
  void initState() {
    super.initState();
    ref.read(friendListProvider.notifier).fetchFriendList();
   
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Friends App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: NavigationService.navigatorKey,
      home: const SplashScreen(),
    );
  }
}
