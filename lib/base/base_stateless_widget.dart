import 'package:flutter/material.dart';
import 'package:flutter_project_frame/base/base_controller.dart';
import 'package:flutter_project_frame/widgets/load_state_widget.dart';
import 'package:flutter_project_frame/widgets/loading_widget.dart';
import 'package:get/get.dart';

///常用页面无状态page封装，基本依赖Controller+OBX实现原有State+StatefulWidget效果
abstract class BaseStatelessWidget<T extends BaseController>
    extends GetView<T> {
  const BaseStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(context),
      body: _buildBody(context),
      drawer: showDrawer() ? createDrawer() : null,
    );
  }

  ///AppBar生成逻辑
  AppBar? _createAppBar(BuildContext context) {
    if (showTitleBar()) {
      return createAppBar(
          titleString(), showBackButton(), appBarActionWidget(context),
          titleWidget: titleWidget());
    } else {
      return null;
    }
  }

  /// 构建侧边栏内容
  Widget createDrawer() {
    return Container();
  }

  /// 创建AppBar ActionView
  List<Widget>? appBarActionWidget(BuildContext context) {}

  /// 构建Scaffold-body主体内容
  Widget _buildBody(BuildContext context) {
    if (showLoadWidget()) {
      return controller.obx((state) => buildContent(context),
          onLoading: Center(
            child: LoadingWidget(),
          ),
          onError: (error) => createErroWidget(controller, error),
          onEmpty: createEmptyWidget(controller));
    } else {
      return buildContent(context);
    }
  }

  /// 是否显示titleBar标题栏
  bool showTitleBar() => true;

  /// 侧边栏
  bool showDrawer() => false;

  /// 页面标题设置
  String titleString() => "";

  /// 标题栏title的Widget
  Widget? titleWidget() {}

  /// 是否开启加载状态
  bool showLoadWidget() => true;

  /// 是否展示回退按钮
  bool showBackButton() => true;

  /// showSuccess显示成功的布局
  Widget buildContent(BuildContext context);
}
