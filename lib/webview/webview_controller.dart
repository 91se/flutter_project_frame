import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_project_frame/utils/log_utils/log_util.dart';

/// WebView Controller，与h5交互传参的方法都统一写在这里
class WebViewController {
  InAppWebViewController? webViewController;

  /// 示例：自定义方法，在 InAppWebView 部件的 onWebViewCreated属性里调用该方法
  /// handlerName：注册一个JS处理方法，与js代码中的处理方法名称一致
  /// args：为js方传递过来的参数，任意类型数据，数组、对象等
  /// return：为 flutter给js的数据
  void jsBride() {
    webViewController?.addJavaScriptHandler(
        handlerName: "myHandlerName",
        callback: (args) {
          LogUtils.d(
              message: 'args=js方传递过来的参数============================$args');
          // 传给js方的参数
          return "flutter给js的数据";
        });
  }
}
