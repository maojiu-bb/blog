import 'package:blog/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutePages {
  static List<String> history = [];
  static final RouteObserver<Route> observer = RouteObservers();
  static List<GetPage> pages = [
    GetPage(
      name: RouteNames.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RouteNames.about,
      page: () => const AboutPage(),
    ),
    GetPage(
      name: RouteNames.blog,
      page: () => const BlogPage(),
    ),
    GetPage(
      name: RouteNames.project,
      page: () => const ProjectPage(),
    ),
    GetPage(
      name: RouteNames.resource,
      page: () => const ResourcePage(),
    ),
  ];
}
