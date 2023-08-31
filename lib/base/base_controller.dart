import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_project_frame/controller/theme_controller.dart';
import 'package:flutter_project_frame/http/app_except.dart';
import 'package:flutter_project_frame/utils/log_utils/log_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Controller基类，统一控制页面加载中、加载异常、空页面状态、换肤
class BaseController extends SuperController {
  /// 标题
  RxString barTitleString = "".obs;

  /// 换肤controller
  var themeController = Get.find<ThemeController>();

  /// 监听网络连接
  late StreamSubscription<ConnectivityResult> subscription;
  ValueNotifier<bool> isDeviceConnected = ValueNotifier(false);

  late CancelToken cancelToken;

  @override
  void onInit() {
    super.onInit();
    cancelToken = CancelToken();
  }

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void onClose() {
    super.onClose();

    /// 关闭页面时取消网络请求
    cancelToken.cancel();
  }

  @override
  void onReady() {
    super.onReady();
    checkNet();
  }

  /// 加载网络数据
  void loadNet() {}

  /// 显示成功的页面
  void showSuccess() {
    change(null, status: RxStatus.success());
  }

  /// 显示空页面
  void showEmpty() {
    change(null, status: RxStatus.empty());
  }

  /// 显示错误页面
  void showError({String? errorMessage, Exception? e}) {
    if (e != null) {
      if (e is DioError && e.error is AppException) {
        var error = e.error as AppException;
        change(null, status: RxStatus.error(error.message));
      } else {
        change(null, status: RxStatus.error(errorMessage));
      }
    } else {
      change(null, status: RxStatus.error(errorMessage));
    }
  }

  /// 显示加载页面
  void showLoading() {
    change(null, status: RxStatus.loading());
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  /// 检查网络
  void checkNet() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        // 监听是否已连接wifi或移动数据。。。
        isDeviceConnected.value =
            await InternetConnectionChecker().hasConnection;
        if (isDeviceConnected.value) {
          // 判断连接网络是否成功
          LogUtils.e(message: "网络已连接...");
          SmartDialog.dismiss();
          loadNet();
        } else {
          SmartDialog.showLoading(
              msg: "网络异常，请检查网络连接！", clickMaskDismiss: false);
          LogUtils.e(message: "网络已断开...");
        }
      } else {
        SmartDialog.showLoading(msg: "网络异常，请检查网络连接！", clickMaskDismiss: false);
        LogUtils.e(message: "网络异常");
      }
    });
  }
}
