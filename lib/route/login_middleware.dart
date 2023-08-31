import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

///登陆拦截中间件
class LoginMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  LoginMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    // 判断是否登录，没有登录则跳至登录页
    return const RouteSettings(name: "/login");
  }
}
