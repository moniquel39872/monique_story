import 'package:flutter/material.dart';
import 'package:kombat_flutter/theme/app_theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    extensions: <ThemeExtension<dynamic>>[
      AppThemeColors.light(),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    extensions: <ThemeExtension<dynamic>>[
      AppThemeColors.dark(),
    ],
  );
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  AppTheme() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((storage) {
      final value = storage.get('themeMode');

      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeMode = ThemeMode.light;
        notifyListeners();
      } else {
        _themeMode = ThemeMode.dark;
        notifyListeners();
      }
    });
  }
}