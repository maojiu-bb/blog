import 'package:blog/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Global {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Storage().init();

    Get.put<ConfigService>(ConfigService());
  }
}
