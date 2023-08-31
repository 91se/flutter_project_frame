import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

/// 权限申请dialog工具类
class PermissionUtils {
  /// androidStatus 安卓权限
  /// iosStatus  ios权限
  /// title  弹窗标题
  /// content 弹窗内容
  static Future<bool> requestPermission(
      {androidStatus, iosStatus, title, content}) async {
    late PermissionStatus status;

    if (Platform.isIOS) {
      status = iosStatus;
    } else {
      status = androidStatus;
    }
    // 异步中使用context时使用mounted检查
    if (status != PermissionStatus.granted) {
      showCupertinoDialog(
          context: Get.context!,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("取消"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("确定"),
                  onPressed: () {
                    Navigator.pop(context);
                    // 打开手机上该app权限的页面
                    openAppSettings();
                  },
                ),
              ],
            );
          });
    } else {
      return true;
    }
    return false;
  }
}
