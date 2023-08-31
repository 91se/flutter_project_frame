import 'dart:ui' as ui show window;

import 'package:flutter/material.dart';
import 'package:flutter_project_frame/base/base_stateless_widget.dart';
import 'package:flutter_project_frame/generated/assets.dart';
import 'package:flutter_project_frame/res/strings.dart';
import 'package:flutter_project_frame/route/route_utils.dart';
import 'package:flutter_project_frame/utils/image_util.dart';
import 'package:flutter_project_frame/widgets/skip_down_time_progress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

/// 启动页
class SplashPage extends BaseStatelessWidget<SplashController> {
  SplashPage({Key? key}) : super(key: key);

  final SplashController controller = Get.put(SplashController());

  // 广告图
  String imgUrl =
      "https://p3-tt.byteimg.com/origin/pgc-image/152153854853908f3a975b3?from=pc";

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        imageContainer(),
        timerVisibility(),
      ],
    );
  }

  @override
  bool showLoadWidget() {
    return false;
  }

  @override
  bool showTitleBar() {
    return false;
  }

  /// 加载广告图
  Widget imageContainer() {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.white,
      child: ImageUtils.loadNetworkImage(imgUrl,
          placeholder: Assets.imagesSplashBg),
    );
  }

  /// 倒计时
  Widget timerVisibility() {
    return Visibility(
      child: Positioned(
        top: MediaQueryData.fromView(ui.window).padding.top + 20.w,
        right: 30.w,
        child: SkipDownTimeProgress(
          /// 自定义倒计时部件
          color: Colors.red,
          radius: 22.sp,
          duration: const Duration(seconds: 3),
          size: Size(25.sp, 25.sp),
          skipText: Strings.jumpOver,
          onTap: () => Get.offNamed(RouteUtils.mainPage),
          onFinishCallBack: (bool value) {
            if (value) {
              /// 倒计时结束自动跳转主页
              Get.offNamed(RouteUtils.mainPage);
            }
          },
        ),
      ),
    );
  }
}
