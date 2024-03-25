import 'package:blog/index.dart';
import 'package:get/get.dart';

class Global {
  Future<void> init() async {
    await Storage().init();

    Get.lazyPut<ConfigService>(() => ConfigService());
  }
}
