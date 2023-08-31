import 'package:flutter/material.dart';

/// 游戏页面
class GamePage extends StatelessWidget {
  GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '游戏页面',
      home: Scaffold(
        appBar: AppBar(
          title: Text('游戏页面'),
        ),
        body: Center(
          child: Container(
            child: Text('游戏页面'),
          ),
        ),
      ),
    );
  }
}
