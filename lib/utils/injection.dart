import 'package:flutter_project_frame/controller/theme_controller.dart';
import 'package:get/get.dart';

/// 初始化注入对象
class Injection extends GetxService {
  Future<void> init() async {
    Get.lazyPut(() => ThemeController(), fenix: true);
  }
}
