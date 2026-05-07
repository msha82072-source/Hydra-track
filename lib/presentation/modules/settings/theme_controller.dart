import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/theme/app_theme.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'themeMode';

  ThemeMode get themeMode {
    String? storedTheme = _storage.read(_key);
    if (storedTheme == 'dark') return ThemeMode.dark;
    if (storedTheme == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;
  bool get isBlackMode => _storage.read('isBlackMode') ?? false;

  void switchTheme() {
    if (isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      _storage.write(_key, 'light');
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      _storage.write(_key, 'dark');
    }
  }

  void toggleBlackMode(bool value) {
    _storage.write('isBlackMode', value);
    if (value) {
      Get.changeTheme(AppTheme.blackTheme);
    } else {
      Get.changeTheme(isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme);
    }
    update();
  }
}
