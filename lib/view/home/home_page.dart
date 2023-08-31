import 'package:flutter/material.dart';
import 'package:flutter_project_frame/base/base_stateless_widget.dart';
import 'package:flutter_project_frame/controller/home/home_controller.dart';
import 'package:get/get.dart';

/// 首页
class HomePage extends BaseStatelessWidget<HomeController> {
  HomePage({Key? key}) : super(key: key);
  final logic = Get.put(HomeController());
  @override
  bool showTitleBar() {
    return false;
  }

  @override
  bool showLoadWidget() {
    return false;
  }

  @override
  Widget buildContent(BuildContext context) {
    return MaterialApp(
      title: '首页',
      home: Scaffold(
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: Center(
          child: Container(
            child: Text('首页'),
          ),
        ),
      ),
    );
  }
}
