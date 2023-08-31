import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_project_frame/utils/string_util.dart';
import 'package:flutter_project_frame/webview/webview_controller.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 自定义 WebViewPage
class WebViewPage extends StatefulWidget {
  String? title;
  String? url;
  bool? isShowAppBar;
  bool? isLocalUrl;
  bool? isAllowBack;

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }

  WebViewPage(
      {Key? key,
      this.title,
      this.url,
      this.isShowAppBar,
      this.isLocalUrl,
      this.isAllowBack})
      : super(key: key);
}

class _WebViewPageState extends State<WebViewPage> {
  ///标题
  String _title = "";

  /// assets/web 本地目录html或web_url
  String _url = "";

  /// url是否为本地html
  bool _isLocalUrl = false;

  /// 是否显示标题栏
  bool _isShowAppBar = true;

  /// 是否禁止返回
  bool _isAllowBack = true;

  Uri uri = Uri.parse('');
  double progress = 0;

  InAppWebViewController? _webViewController;
  WebViewController logic = WebViewController();

  /// 下拉刷新
  late PullToRefreshController pullToRefreshController;
  final GlobalKey webViewKey = GlobalKey();

  // webview配置
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    // 跨平台配置
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
    ),
    // Android平台配置
    android: AndroidInAppWebViewOptions(
      // 支持 HybridComposition
      useHybridComposition: true,
    ),
    // iOS 平台配置
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  void initState() {
    super.initState();

    /// 初始化变量
    _title = (StringUtils.isNotEmpty(widget.title) ? widget.title! : "");
    _url = (StringUtils.isNotEmpty(widget.url) ? widget.url! : "");
    _isLocalUrl = widget.isLocalUrl ?? false;
    _isShowAppBar = widget.isShowAppBar ?? true;
    _isAllowBack = widget.isAllowBack ?? true;

    /// 配置下拉刷新
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          _webViewController?.reload();
        } else if (Platform.isIOS) {
          _webViewController?.loadUrl(
              urlRequest: URLRequest(url: await _webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(_isAllowBack ? true : false);
      },
      child: MaterialApp(
        home: Scaffold(
          /// 是否显示标题栏
          appBar: _isShowAppBar
              ? AppBar(centerTitle: true, title: Text(_title))
              : null,
          body: Column(
            children: <Widget>[
              Container(
                /// 加载进度条
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container(),
              ),
              Expanded(
                /// 主要的 webview 部件
                child: mInAppWebView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// InAppWebView 部件
  Widget mInAppWebView() {
    return InAppWebView(
      /// 下拉刷新
      pullToRefreshController: pullToRefreshController,
      key: webViewKey,

      /// 是否显示本地html
      initialFile: _isLocalUrl ? _url : null,

      /// 加载网络html
      initialUrlRequest: URLRequest(url: Uri.parse(_url)),

      initialOptions: options,
      onWebViewCreated: (InAppWebViewController controller) {
        _webViewController = controller;
        logic.webViewController = controller;

        // 与js互调的方法都集中写在该方法内
        _jsBride();
      },

      onConsoleMessage: (controller, consoleMessage) {
        // LogUtils.d("consoleMessage==来自于js的打印====$consoleMessage");
      },

      onLoadStart: (InAppWebViewController controller, Uri? uri) {
        setState(() {
          this.uri = uri!;
        });
      },

      onLoadStop: (InAppWebViewController controller, Uri? uri) {
        pullToRefreshController.endRefreshing();
        setState(() {
          this.uri = uri!;
        });
      },
      onLoadError: (InAppWebViewController controller, Uri? uri, int code,
          String message) {
        pullToRefreshController.endRefreshing();
        SmartDialog.showToast(message);
      },

      onProgressChanged: (InAppWebViewController controller, int progress) {
        if (progress == 100) {
          pullToRefreshController.endRefreshing();
        }
        setState(() {
          this.progress = progress / 100;
        });
      },
    );
  }

  /// TODO 与js互调
  void _jsBride() {
    logic.jsBride();
  }
}
