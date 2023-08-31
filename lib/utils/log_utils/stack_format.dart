import 'package:flutter_project_frame/utils/log_utils/log_print.dart';

class StackFormatter implements ILogFormatter<List<String>> {
  @override
  String format(List<String> stackList) {
    ///每一行都设置成单独的 字符串
    StringBuffer sb = StringBuffer();

    ///堆栈是空的直接返回
    if (stackList.isEmpty) {
      return "";

      ///堆栈只有一行那么就返回 - 堆栈
    } else if (stackList.length == 1) {
      return "\n\t-${stackList[0].toString()}\n";

      ///多行堆栈格式化
    } else {
      for (int i = 0; i < stackList.length; i++) {
        if (i == 0) {
          sb.writeln("\n\t┌StackTrace:");
        }
        if (i != stackList.length - 1) {
          sb.writeln("\t├${stackList[i].toString()}");
        } else {
          sb.write("\t└${stackList[i].toString()}");
        }
      }
    }
    return sb.toString();
  }
}
