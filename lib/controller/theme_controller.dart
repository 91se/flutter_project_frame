import 'package:flutter/material.dart';
import 'package:flutter_project_frame/utils/theme_utils.dart';
import 'package:get/get.dart';

/// 换肤
class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  ThemeData get themeData => isDarkMode.value ? Themes.black : Themes.blue;
}
