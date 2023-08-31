import 'package:flutter_project_frame/utils/log_utils/log_config.dart';
import 'package:flutter_project_frame/utils/log_utils/log_print.dart';

class LogManager {
  ///config
  late LogConfig _config;

  ///打印器列表
  List<ILogPrint> _printers = [];

  ///单例模式
  static LogManager? _instance;

  factory LogManager() => _instance ??= LogManager._();

  LogManager._();

  ///初始化 Manager方法
  LogManager.init({config, printers}) {
    _config = config;
    _printers.addAll(printers);
    _instance = this;
  }

  get printers => _printers;

  get config => _config;

  void addPrinter(ILogPrint print) {
    bool isHave = _printers.any((element) => element == print);
    if (!isHave) {
      _printers.add(print);
    }
  }

  void removePrinter(ILogPrint print) {
    _printers.remove(print);
  }
}
