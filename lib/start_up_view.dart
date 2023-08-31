import 'package:flutter/material.dart';
import 'package:flutter_project_frame/route/route_utils.dart';
import 'package:flutter_project_frame/utils/injection.dart';
import 'package:flutter_project_frame/utils/log_utils/console_print.dart';
import 'package:flutter_project_frame/utils/log_utils/log_config.dart';
import 'package:flutter_project_frame/utils/log_utils/log_manager.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

/// 应用主入口
void main() async {
  /// 不加这个,webview 强制横/竖屏会报错
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化 注入
  await Injection().init();

  /// 初始化 Logutils
  LogManager.init(
      config: LogConfig(enable: true, globalTag: "TAG", stackTraceDepth: 5),
      printers: [ConsolePrint()]);

  runApp(StartUpPage());
}

class StartUpPage extends StatelessWidget {
  StartUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      smartManagement: SmartManagement.onlyBuilder,
      initialRoute: RouteUtils.splashPage, //  配置GetX路由
      getPages: RouteUtils.getPages,
      navigatorObservers: [FlutterSmartDialog.observer], // 配置 SmartDialog
      builder: FlutterSmartDialog.init(),
    );
  }
}
