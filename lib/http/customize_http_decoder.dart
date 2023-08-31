import 'package:flutter_nb_net/flutter_net.dart';
import 'package:flutter_project_frame/http/app_except.dart';

/// 默认自定义解析
class CustomizeHttpDecoder extends NetDecoder {
  /// 单例对象
  static final CustomizeHttpDecoder _instance =
      CustomizeHttpDecoder._internal();

  /// 内部构造方法
  CustomizeHttpDecoder._internal();

  /// 工厂构造方法，用命名构造函数
  factory CustomizeHttpDecoder.getInstance() => _instance;

  @override
  K decode<T, K>({required Response<dynamic> response, T? decodeType}) {
    var errorCode = response.data['errorCode'];

    /// 请求成功
    if (errorCode == 0) {
      var data = response.data['data'];
      if (decodeType is BaseNetModel) {
        if (data is List) {
          var dataList = List<T>.from(
              data.map((item) => decodeType.fromJson(item)).toList()) as K;
          return dataList;
        } else {
          var model = decodeType.fromJson(data) as K;
          return model;
        }
      } else {
        return data as K;
      }
    } else {
      var errorMsg = response.data['errorMsg'];
      throw AppException(errorMsg, errorCode);
    }
  }
}
