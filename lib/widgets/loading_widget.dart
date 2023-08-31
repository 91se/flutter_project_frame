import 'package:flutter/material.dart';
import 'package:flutter_project_frame/generated/assets.dart';
import 'package:flutter_project_frame/widgets/frame_animate_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

////页面加载Loading动画
class LoadingWidget extends StatelessWidget {
  ///gaplessPlayback属性是解决加载帧动画闪烁，根本原因是图片解析速度跟不上帧动画加载速度，导致刚开始加载闪烁
  var imageCache = {
    0: Image.asset(
      Assets.loadingLoding00000,
      gaplessPlayback: true,
    ),
    1: Image.asset(Assets.loadingLoding00001, gaplessPlayback: true),
    2: Image.asset(Assets.loadingLoding00002, gaplessPlayback: true),
    3: Image.asset(Assets.loadingLoding00003, gaplessPlayback: true),
    4: Image.asset(Assets.loadingLoding00004, gaplessPlayback: true),
    5: Image.asset(Assets.loadingLoding00005, gaplessPlayback: true),
    6: Image.asset(Assets.loadingLoding00006, gaplessPlayback: true),
    7: Image.asset(Assets.loadingLoding00007, gaplessPlayback: true),
    8: Image.asset(Assets.loadingLoding00008, gaplessPlayback: true),
    9: Image.asset(Assets.loadingLoding00009, gaplessPlayback: true),
    10: Image.asset(Assets.loadingLoding00010, gaplessPlayback: true),
    11: Image.asset(Assets.loadingLoding00011, gaplessPlayback: true),
    12: Image.asset(Assets.loadingLoding00012, gaplessPlayback: true),
    13: Image.asset(Assets.loadingLoding00013, gaplessPlayback: true),
    14: Image.asset(Assets.loadingLoding00014, gaplessPlayback: true),
    15: Image.asset(Assets.loadingLoding00015, gaplessPlayback: true),
    16: Image.asset(Assets.loadingLoding00016, gaplessPlayback: true),
    17: Image.asset(Assets.loadingLoding00017, gaplessPlayback: true),
    18: Image.asset(Assets.loadingLoding00018, gaplessPlayback: true),
    19: Image.asset(Assets.loadingLoding00019, gaplessPlayback: true),
    20: Image.asset(Assets.loadingLoding00020, gaplessPlayback: true),
    21: Image.asset(Assets.loadingLoding00021, gaplessPlayback: true),
    22: Image.asset(Assets.loadingLoding00022, gaplessPlayback: true),
    23: Image.asset(Assets.loadingLoding00023, gaplessPlayback: true)
  };

  LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameAnimateWidget(imageCache, 200.w, 200.w, Colors.transparent);
  }
}
