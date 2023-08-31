import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_frame/base/base_stateless_widget.dart';
import 'package:flutter_project_frame/controller/main_controller.dart';
import 'package:get/get.dart';

/// 主入口
class MainPage extends BaseStatelessWidget<MainController> {
  MainPage({Key? key}) : super(key: key);

  @override
  bool showLoadWidget() {
    return false;
  }

  @override
  bool showTitleBar() {
    return false;
  }

  @override
  Widget buildContent(BuildContext context) {
    controller.initNavigation();
    return GetBuilder<MainController>(
      builder: (controller) {
        return mScaffold();
      },
    );
  }

  /// PageView
  Widget mScaffold() {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(), //禁止滑动
        controller: controller.pageController,
        children: controller.pageList,
      ),
      bottomNavigationBar: mNavigationContainer(),
    );
  }

  /// 导航栏容器
  Widget mNavigationContainer() {
    return Container(
      child: BrnBottomTabBar(
        currentIndex: controller.selectedIndex,
        onTap: controller.onItemSelected,
        items: mBottomTabBarItem(),
      ),
    );
  }

  /// 设置底部导航栏数据
  List<BrnBottomTabBarItem> mBottomTabBarItem() {
    return controller.navigationList.map((value) {
      return BrnBottomTabBarItem(
        icon: Image(
          image: AssetImage(value.normalIcon!),
        ),
        activeIcon: Image(
          image: AssetImage(value.selectIcon!),
        ),
        title: Text(
          "${value.name}",
        ),
      );
    }).toList();
  }
}

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}
