import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_project_frame/config/http_urls.dart';
import 'package:flutter_project_frame/http/customize_http_decoder.dart';
import 'package:flutter_project_frame/utils/sp_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 初始化应用配置
class InitConfig {
  static initApp(BuildContext? context) async {
    // 屏幕适配
    if (context != null) {
      ScreenUtil.init(context, designSize: const Size(375, 812));
    }
    // 初始化shared_preferences
    SpUtils.init();
    // 配置网络请求
    netConfig();
  }
}

/// 网络请求配置
void netConfig() {
  NetOptions.instance
      // header
      .addHeaders({"aaa": '111'})
      // baseUrl
      .setBaseUrl(HttpUrls.baseUrl)
      // 代理/https
      // .setHttpClientAdapter(IOHttpClientAdapter()
      //   ..onHttpClientCreate = (client) {
      //     client.findProxy = (uri) {
      //       return 'PROXY localhost:8888';
      //     };
      //     client.badCertificateCallback =
      //         (X509Certificate cert, String host, int port) {
      //       return true;
      //     };
      //     return client;
      //   })
      // cookie  缓存cookie
      .addInterceptor(CookieManager(CookieJar()))
      // dio_http_cache
      .addInterceptor(DioCacheManager(CacheConfig(
        baseUrl: HttpUrls.baseUrl,
      )).interceptor)
      // dio_cache_interceptor
      .addInterceptor(DioCacheInterceptor(
          options: CacheOptions(
        store: MemCacheStore(),
        //本地缓存
        policy: CachePolicy.forceCache,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 3),
        priority: CachePriority.normal,
        cipher: null,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      )))
      //  全局自定义解析器
      .setHttpDecoder(CustomizeHttpDecoder.getInstance())
      //  超时时间
      .setConnectTimeout(const Duration(milliseconds: 3000))
      // 允许打印log，默认为 true
      .enableLogger(true)
      .create();
}
