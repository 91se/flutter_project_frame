import 'package:flutter/material.dart';
import 'package:flutter_project_frame/utils/log_utils/log_print.dart';
import 'package:flutter_project_frame/utils/log_utils/log_type.dart';

class ConsolePrint extends ILogPrint {
  @override
  void logPrint(
      {required LogType type,
      required String tag,
      required String message,
      StackTrace? stackTrace,
      Map<String, dynamic>? json}) {
    ///如果要开启颜色显示 那么就是1000
    ///如果不开启颜色显示 那么就是1023
    int _maxCharLength = 1000;

    //匹配中文字符以及这些中文标点符号 。 ？ ！ ， 、 ； ： “ ” ‘ ' （ ） 《 》 〈 〉 【 】 『 』 「 」 ﹃ ﹄ 〔 〕 … — ～ ﹏ ￥
    RegExp _chineseRegex = RegExp(
        r"[\u4e00-\u9fa5|\u3002|\uff1f|\uff01|\uff0c|\u3001|\uff1b|\uff1a|\u201c|\u201d|\u2018|\u2019|\uff08|\uff09|\u300a|\u300b|\u3008|\u3009|\u3010|\u3011|\u300e|\u300f|\u300c|\u300d|\ufe43|\ufe44|\u3014|\u3015|\u2026|\u2014|\uff5e|\ufe4f|\uffe5]");

    ///用回车做分割
    List<String> strList = message.split("\n");

    ///判断每句的长度 如果长度过长做切割
    for (String str in strList) {
      ///获取总长度
      int len = 0;

      ///获取当前长度
      int current = 0;

      ///获取截断点数据
      List<int> entry = [0];

      ///遍历文字 查看真实长度
      for (int i = 0; i < str.length; i++) {
        /// 一个汉字再打印区占三个长度,其他的占一个长度
        len += str[i].contains(_chineseRegex) ? 3 : 1;

        ///寻找当前字符的下一个字符长度
        int next = (i + 1) < str.length
            ? str[i + 1].contains(_chineseRegex)
                ? 3
                : 1
            : 0;

        ///当前字符累计长度 如果达到了需求就清空
        current += str[i].contains(_chineseRegex) ? 3 : 1;
        if (current < _maxCharLength && (current + next) >= _maxCharLength) {
          entry.add(i);
          current = 0;
        }
      }

      ///如果最后一个阶段点不是最后一个字符就添加上
      if (entry.last != str.length - 1) {
        entry.add(str.length);
      }

      ///如果所有的长度小于1023 那么打印没有问题
      if (len < _maxCharLength) {
        _logPrint(type, tag, str);
      } else {
        ///按照获取的截断点来打印
        for (int i = 0; i < entry.length - 1; i++) {
          _logPrint(type, tag, str.substring(entry[i], entry[i + 1]));
        }
      }
    }
  }

  _logPrint(LogType type, String tag, String message) {
    ///前面的\u001b[31m用于设定SGR颜色，后面的\u001b[0m相当于一个封闭标签作为前面SGR颜色的作用范围的结束点标记。
    /// \u001b[3 文字颜色范围 0-7 标准颜色 0是黑色 1是红色 2是绿色 3是黄色 4是蓝色 5是紫色 6蓝绿色 是 7是灰色 范围之外都是黑色
    /// \u001b[9 文字颜色范围 0-7 高强度颜色 0是黑色 1是红色 2是绿色 3是黄色 4是蓝色 5是紫色 6蓝绿色 是 7是灰色 范围之外都是黑色
    /// 自定义颜色 \u001b[38;2;255;0;0m 表示文字颜色 2是24位 255 0 0 是颜色的RGB 可以自定义颜色
    /// \u001b[4 数字 m 是背景色
    /// \u001b[1m 加粗
    /// \u001b[3m 斜体
    /// \u001b[4m 下划线
    /// \u001b[7m 黑底白字
    ///\u001b[9m 删除线
    ///\u001b[0m 结束符
    //详情看 https://www.cnblogs.com/zt123123/p/16110475.html
    String colorHead = "";
    String colorEnd = "\u001b[0m";
    switch (type) {
      case LogType.V:
        // const Color(0xff181818);
        colorHead = "\u001b[38;2;187;187;187m";
        break;
      case LogType.E:
        colorHead = "\u001b[38;2;255;0;6m";
        break;
      case LogType.A:
        colorHead = "\u001b[38;2;143;0;5m";
        break;
      case LogType.W:
        colorHead = "\u001b[38;2;187;187;35m";
        break;
      case LogType.I:
        colorHead = "\u001b[38;2;72;187;49m";
        break;
      case LogType.D:
        colorHead = "\u001b[38;2;0;112;187m";
        break;
    }

    /// 这里是纯Flutter项目所以在控制台打印这样子是可以有颜色的 如果是flutter混编 安卓原生侧打印\u001b 可能是一个乱码也没有变色效果
    /// 如果你不想只在调试模式打印 你可以把debugPrint换成print
    debugPrint("$colorHead$message$colorEnd");

    /// 如果原生侧有封装log工具直接 写一个methodChannel 传参数就好 ,如果没有,可以调用原生的log打印 传入 level tag 和message
    /// kDebugMode 用这个可以判断是否在debug模式下
    /// if(kDebugMode){
    /// 在debug模式下打印日志
    //  bool? result=await CustomChannelUtil.printLog(level:logTypeNum[type.index],tag:tag,message:message);
    /// }
  }
}
