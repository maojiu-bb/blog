import 'package:blog/index.dart';
import 'package:get/get.dart';

class ConfigService extends GetxService {
  static ConfigService get to => Get.find<ConfigService>();

  final _isDarkMode = Get.isDarkMode.obs;
  get isDarkMode => _isDarkMode.value;
  set isDarkMode(value) => _isDarkMode.value = value;

  Future<void> switchTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeTheme(_isDarkMode.value == true ? AppTheme.dark : AppTheme.light);

    Future.delayed(const Duration(milliseconds: 250), () {
      Get.forceAppUpdate();
    });

    await Storage().setString(
      Constants.storageThemeCode,
      _isDarkMode.value == true ? "dark" : "light",
    );
  }

  Future<void> initTheme() async {
    var themeCode = Storage().getString(Constants.storageThemeCode);
    _isDarkMode.value = themeCode == "dark" ? true : false;
    Get.changeTheme(
      themeCode == "dark" ? AppTheme.dark : AppTheme.light,
    );
  }

  Future<ConfigService> init() async {
    await initTheme();
    return this;
  }
}
