import 'package:blog/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global.dart';

Future<void> main() async {
  await Global().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blog',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.size,
      initialRoute: RouteNames.home,
      getPages: RoutePages.pages,
      navigatorObservers: [RoutePages.observer],
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ConfigService.to.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
