import 'package:flutter_project_frame/utils/log_utils/log_type.dart';

/// 日志打印输出的接口类
abstract class ILogPrint {
  void logPrint({
    required LogType type,
    required String tag,
    required String message,
    StackTrace? stackTrace,
    Map<String, dynamic>? json,
  });
}

///格式化的接口类
abstract class ILogFormatter<T> {
  String format(T data);
}
