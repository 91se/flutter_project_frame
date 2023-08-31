import 'package:flutter_project_frame/start_up_view.dart';
import 'package:flutter_project_frame/view/home/home_page.dart';
import 'package:flutter_project_frame/view/main_view.dart';
import 'package:flutter_project_frame/view/splash_view.dart';
import 'package:get/get.dart';

/// 路由配置
class RouteUtils {
  /// root page
  static const String startUpPage = "/";
  static const String splashPage = "/SplashPage";
  static const String mainPage = "/mainPage";
  static const String homePage = "/HomePage";

  /// pages map
  static final List<GetPage> getPages = [
    GetPage(name: startUpPage, page: () => StartUpPage()),
    GetPage(name: splashPage, page: () => SplashPage()),
    GetPage(name: mainPage, page: () => MainPage(), binding: MainBinding()),
    GetPage(
      name: homePage,
      page: () => HomePage(),
    ),
  ];
}
