import 'package:flutter_project_frame/base/base_controller.dart';
import 'package:flutter_project_frame/config/init_config.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();

    /// 初始化配置
    InitConfig.initApp(Get.context);
  }
}
