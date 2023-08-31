import 'package:flutter/material.dart';

/// 我的页面
class MinePage extends StatelessWidget {
  MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的',
      home: Scaffold(
        appBar: AppBar(
          title: Text('我的'),
        ),
        body: Center(
          child: Container(
            child: Text('我的'),
          ),
        ),
      ),
    );
  }
}
