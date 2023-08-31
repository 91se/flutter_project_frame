import 'package:flutter_project_frame/utils/log_utils/log_print.dart';

class LogConfig {
  ///是否开启日志
  bool _enable = false;

  ///默认的Tag
  String _globalTag = "LogTag";

  ///堆栈显示的深度
  int _stackTraceDepth = 0;

  ///打印的方式
  List<ILogPrint>? _printers;

  LogConfig({enable, globalTag, stackTraceDepth, printers}) {
    _enable = enable;
    _globalTag = globalTag;
    _stackTraceDepth = stackTraceDepth;
    _printers?.addAll(printers);
  }

  @override
  String toString() {
    return 'LogConfig{_enable: $_enable, _globalTag: $_globalTag, _stackTraceDepth: $_stackTraceDepth, _printers: $_printers}';
  }

  get enable => _enable;

  get globalTag => _globalTag;

  get stackTraceDepth => _stackTraceDepth;

  get printers => _printers;
}
