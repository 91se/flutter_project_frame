import 'package:flutter/material.dart';
import 'package:flutter_project_frame/base/base_controller.dart';
import 'package:flutter_project_frame/generated/assets.dart';
import 'package:flutter_project_frame/model/navigation_bean.dart';
import 'package:flutter_project_frame/view/game/game_page.dart';
import 'package:flutter_project_frame/view/home/home_page.dart';
import 'package:flutter_project_frame/view/mine/mime_page.dart';

/// 主入口控制器
class MainController extends BaseController {
  // 底部导航栏
  List<NavigationBean> navigationList = [];

  // 页面
  List<Widget> pageList = [HomePage(), GamePage(), MinePage()];

  // 导航栏标题
  List titleList = ['首页', '游戏', '我的'];

  // 选中图片
  var selectImageList = [
    Assets.imagesHomeSelect,
    Assets.imagesGameSelect,
    Assets.imagesMineSelect
  ];

  // 未选中图片
  var normalImageList = [
    Assets.imagesHomeNormal,
    Assets.imagesGameNormal,
    Assets.imagesMineNormal
  ];

  final PageController pageController = PageController();

  // 切换页面索引
  int selectedIndex = 0;

  // 初始化底部导航栏数据
  void initNavigation() {
    if (navigationList.isNotEmpty) {
      navigationList.clear();
    }
    NavigationBean navigationBean;
    for (var i = 0; i < titleList.length; i++) {
      navigationBean = NavigationBean();
      navigationBean.name = titleList[i];
      navigationBean.selectIcon = selectImageList[i];
      navigationBean.normalIcon = normalImageList[i];
      navigationList.add(navigationBean);
    }
  }

  // 切换页面
  void onItemSelected(int index) {
    pageController.jumpToPage(index);

    /// 置为当前选中item的索引值
    selectedIndex = index;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
