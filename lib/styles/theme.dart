import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'index.dart';

/// 主题
class AppTheme {
  // light
  static ThemeData light = ThemeData(
    colorScheme: lightColorScheme,
    appBarTheme: const AppBarTheme(
      // 与主题色相反
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      // 标题剧中
      centerTitle: true,
    ),
  );

  // dark
  static ThemeData dark = ThemeData(
    colorScheme: darkColorScheme,
    appBarTheme: const AppBarTheme(
      // 与主题色相反
      systemOverlayStyle: SystemUiOverlayStyle.light,
      // 标题剧中
      centerTitle: true,
    ),
  );
}
