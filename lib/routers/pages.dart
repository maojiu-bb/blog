import 'package:blog/index.dart';
import 'package:flutter/material.dart';

class RoutePages {
  static List<String> history = [];
  static final RouteObserver<Route> observer = RouteObservers();
}
