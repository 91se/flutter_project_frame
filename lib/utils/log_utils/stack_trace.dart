import 'dart:math';

class StackTraceUtil {
  ///正则表达式 表示#+数字+空格的格式
  static final RegExp _startStr = RegExp(r'#\d+[\s]+');

  ///正则表达式表示 多个非换行符+ (非空) 正则表达式中()代表子项 如果需要正则()需要转义\( \)
  ///了解更多 https://www.runoob.com/regexp/regexp-syntax.html
  static final RegExp _stackReg = RegExp(r'.+ \(([^\s]+)\)');

  /// 把StackTrace 转成list 并去除无用信息
  /// [stackTrace] 堆栈信息
  ///#0      LogUtil._logPrint (package:com.halfcity.full_flutter_app/utils/log/log_util.dart:104:42)
  static List<String> _fixStack(StackTrace stackTrace) {
    List tempList = stackTrace.toString().split("\n");
    List<String> stackList = [];
    for (String str in tempList) {
      if (str.startsWith(_startStr)) {
        //又是#号又是空格比较占地方 这里省去了 如果你不想省去直接传入str即可
        stackList.add(str.replaceFirst(_startStr, ' '));
      }
    }
    return stackList;
  }

  ///获取剔除忽略包名及其其他无效信息的堆栈
  /// [stackTrace] 堆栈
  /// [ignorePackage] 需要忽略的包名
  static List<String> _getRealStackTrack(
      StackTrace stackTrace, String ignorePackage) {
    ///由于Flutter 上的StackTrack上的不太一样,Android返回的是list flutter返回的是StackTrack 所以需要手动切割 再处理
    List<String> stackList = _fixStack(stackTrace);
    int ignoreDepth = 0;
    int allDepth = stackList.length;
    //倒着查询 查到倒数第一包名和需要屏蔽的包名一致时,数据往上的数据全部舍弃掉
    for (int i = allDepth - 1; i > -1; i--) {
      Match? match = _stackReg.matchAsPrefix(stackList[i]);
      //如果匹配且第一个子项也符合  group 0 表示全部 剩下的数字看子项的多少返回
      if (match != null &&
          (match.group(1)!.startsWith("package:$ignorePackage"))) {
        ignoreDepth = i + 1;
        break;
      }
    }
    stackList = stackList.sublist(ignoreDepth);
    return stackList;
  }

  /// 裁切堆栈
  /// [stackTrace] 堆栈
  /// [maxDepth] 深度
  static List<String> _cropStackTrace(List<String> stackTrace, int? maxDepth) {
    int realDeep = stackTrace.length;
    realDeep =
        maxDepth != null && maxDepth > 0 ? min(maxDepth, realDeep) : realDeep;
    return stackTrace.sublist(0, realDeep);
  }

  ///裁切获取到最终的stack 并获取最大深度的栈信息

  static getCroppedRealStackTrace(
      {required StackTrace stackTrace, ignorePackage, maxDepth}) {
    return _cropStackTrace(
        _getRealStackTrack(stackTrace, ignorePackage), maxDepth);
  }
}
