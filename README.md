# flutter_project_frame

flutter项目脚手架

## Getting Started

# Flutter分层开发架构脚手架
### 使用到的一些三方框架：
```
  检查网络连接：https://pub.dev/packages/connectivity_plus、https://pub:dev/packages/internet_connection_checker
  connectivity_plus: ^4.0.2
  internet_connection_checker: ^1.0.0+1

  网络请求以及相关的缓存库：https://pub.dev/packages/flutter_nb_net/install
  flutter_nb_net: ^1.0.3
  dio_cache_interceptor: ^3.4.2
  dio_cookie_manager: ^3.1.0
  dio_http_cache_lts: ^0.4.1
  
  GetX 状态管理、路由、国际化、主题框架库：https://pub.dev/packages/get#state-management
  get: ^4.6.5
  
  屏幕适配：https://pub.dev/packages/flutter_screenutil
  flutter_screenutil: ^5.9.0
  
  权限管理：https://pub.dev/packages/permission_handler
  permission_handler: ^10.4.3
  
  图片缓存：https://pub.dev/packages/cached_network_image
  cached_network_image: ^3.2.3
  
  持久化存储：https://pub.dev/packages/shared_preferences
  synchronized: ^3.1.0
  shared_preferences: ^2.2.0
  
  数据格式化处理： https://pub.dev/packages/decimal、https://pub.dev/packages/rational
  decimal: ^2.3.3
  rational: ^2.2.2
  
  isar 数据库相关：https://pub.dev/packages/isar    isar_flutter_libs，https://pub.dev/packages/isar_flutter_libs   获取文件路径：path_provider
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.0
  
  万能dialog：https://pub-web.flutter-io.cn/packages/flutter_smart_dialog/install
  flutter_smart_dialog: ^4.9.3+2
  
  bruno UI组件库：https://gitee.com/mirrors/Bruno#%E6%8E%A5%E5%85%A5
  bruno: ^3.4.0
  
  webview库：https://pub.dev/packages/flutter_inappwebview
  flutter_inappwebview: ^5.7.2+3
  
  日志打印框架：https://pub.dev/packages/logger
  logger: ^1.3.0
  ```

### 使用的一些插件：

  ```
  JsonToDart插件：-将json转化成Dart实体类
  FlutterAssetsGenerator：一款Flutter资源索引插件
  Flutter Snippets：  —模版代码生成插件
  ```
### GetX 换肤功能使用：
##### 在合适的地方使用以下方式设置换肤开关，在 Themes类中可以自定义主题样式，同时在load_state_widget文件中修改状态栏和导航栏颜色。
以下为示例代码：
``` dart
Switch(
              value: controller.themeController.isDarkMode.value,
              onChanged: (bool open) {
			   controller.themeController.isDarkMode.value = open;
                if (open) {
                  Get.changeTheme(Themes.black);
                } else {
                  Get.changeTheme(Themes.blue);
                }
                Get.forceAppUpdate();
              }),
```

### GetX 状态管理使用：
继承 BaseStatelessWidget 和 BaseController 结合obx或者GetBuilder使用，详看GetX使用文档：https://github.com/jonataslaw/getx

### GetX 路由功能使用：
统一配置在 RouteUtils 类中，详细使用查看GetX文档。

### 屏幕适配：
在 InitConfig 类中完成初始化配置：
```
ScreenUtil.init(context, designSize: const Size(375, 812));
```

###  SharedPreferences本地持久化数据存储：
```
SpUtils.puttString      ->存储数据
SpUtils.getXXX    -> 获取数据
```

### 图片加载：
```
ImageUtils.loadXXX -> 加载本地或网络图片
加载本地图片资源时可结合 FlutterAssetsGenerator 插件方便使用
```

### 动态权限管理：
``` dart
Android配置：按需在“AndroidManifest.xml”添加本项目需要用到的权限：
<!-- 写权限 -->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<!-- 读权限 -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

IOS配置：
1：在 podfile 文件中配置所需的权限。
2：在info.plist 文件中添加所需的权限描述，如下：
<!-- 保存图片权限 -->
<key>NSPhotoLibraryAddUsageDescription</key>
<string>请允许APP将照片保存到相册</string>
3：权限申请代码：
onPressed: () async {
          bool permission = await PermissionUtils.requestPermission(
              androidStatus: await Permission.storage.request(),
              iosStatus: await Permission.photosAddOnly.request(),
              title: "您需要授予相册权限",
              content: "请到您的手机设置打开对应相册的权限");
          // 如果已获取权限
          permission ? saveNetworkImg('imgUrl') : null;
        }
```

### 万能dialog简单用法:
``` dart
SmartDialog.showToast("吐司");
SmartDialog.showLoading(msg: "加载中...");
```

### webview库：
```  dart
一：使用：
 Get.to(
              WebViewPage(
                isShowAppBar: true,
                title: "标题",
                url: webUrl,
                isLocalUrl: false,
                isShowBack: true,
              ),
            );
二：与h5交互：
移动端在 WebViewController 编写自定义方法，在 WebViewPage 中调用该方法。
三：h5端代码示例：
 <script>
        // 下面的"flutterInAppWebViewPlatformReady"为固定写法
        // "myHandlerName"与flutter中注册的JS处理方法名称一致
        window.addEventListener("flutterInAppWebViewPlatformReady", function () {
            // 方法1
            window.flutter_inappwebview
                .callHandler("myHandlerName", "这里是传给flutter的参数")
                .then(function (res) {
                    console.log("res========flutter给html的数据", res);
                })
            // 方法2   ....
        })
    </script>
```

### 日志打印框架:
``` dart 
LogUtils.e(message: "日志打印");
LogUtils.w(message: "日志打印");
LogUtils.i(message: "日志打印");
....
```

### UI组件库
```
bruno UI组件库：https://bruno.ke.com/page/widgets/brn-abnormal-state-widget
```

### 数据库
```
isar数据库：https://isar.dev/zh/tutorials/quickstart.html
```

### 网络请求：https://pub.dev/packages/flutter_nb_net/install
``` dart
在 InitConfig 类中设置网络请求相关配置，在根路由页面中进行初始化。
根据项目具体业务这 CustomizeHttpDecoder 类中实现自定义数据解析。
配置 cancelToken 参数来取消异步请求。
以下为代码示例：
/// Get1 请求原始json数，不必写泛型，也不传decodeType
  void requestGet1() async {
    var appResponse = await get("banner/json");
    appResponse.when(success: (response) {
      debugPrint("json=>$response");
      var testData = TestModel().fromJson(response);
      if (testData.errorCode == 0) {
        debugPrint("请求成功");
      } else {
        debugPrint("请求失败");
      }
    }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
    });
  }

  /// Get2 请求数据，不带泛型
  void requestGet2() async {
    var appResponse = await get("banner/json", decodeType: BannerModel());
    appResponse.when(success: (model) {
      if (model.errorCode == 0) {
        debugPrint("请求成功");
      } else {
        debugPrint("请求失败");
      }
    }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
    });
  }

  /// Get3 请求数据，完整的泛型，get<BannerModel, BannerModel>这里有两个泛型，前者是接口返回的数据需要序列化的类型，后者是开发关注的类型。
  /// 比如接口返回一个用户列表，前面泛型就是User类型，后面是List<User>。
  /// 又或者接口返回的数据包了几层，只需要最里面的数据格式，那么前面就是需要序列化的整个数据类型，第二个泛型是最里面的数据类型
  void requestGet3() async {
    var appResponse = await get<BannerModel, BannerModel>("banner/json",
        decodeType: BannerModel());

    ///  这里可加自定义解析器 httpDecode
    appResponse.when(success: (BannerModel model) {
      if (model.errorCode == 0) {
        debugPrint("请求成功");
      } else {
        debugPrint("请求失败");
      }
    }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
    });
  }

  /// Get4 请求数据，内部带泛型， get<TestDataBean, List<TestDataBean>> 这里   的TestDataBean为内层包裹的数据，使用MyHttpDecoder自定义解析之后返回。
  void requestGet4() async {
    var test = await get<TestDataBean, List<TestDataBean>>("banner/json",
        decodeType: TestDataBean(), httpDecode: MyHttpDecoder.getInstance());

    test.when(success: (List<TestDataBean> model) {
      for (var m in model) {
        debugPrint("----${m.title}");
      }
    }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
    });
  }

  /// Post 请求
  void requestPost() async {
    var appResponse = await post<UserWrapperModel, UserWrapperModel>(
        "user/login",
        decodeType: UserWrapperModel(),
        queryParameters: {"username": '你的账号', "password": '你的密码'});
    appResponse.when(success: (UserWrapperModel model) {
      var nickname = model.data?.nickname;
      debugPrint("成功返回nickname=$nickname");
    }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
    });
  }

  /// 自定义Decoder的 Post 请求
  void requestCustomDecoderPost() async {
    var appResponse = await post<UserModel, UserModel>("user/login",
        decodeType: UserModel(),
        httpDecode: MyHttpDecoder.getInstance(),
        queryParameters: {"username": '', "password": ''});
    appResponse.when(success: (UserModel model) {
      var nickname = model.nickname;
      debugPrint("成功返回nickname=$nickname");
    }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
    });
  }

  /// 自定保存和携带 cookie 的请求
  void requestCookieGet() async {
    var appResponse = await get<CollectModel, CollectModel>(
        "lg/collect/list/0/json",
        decodeType: CollectModel(),
        httpDecode: MyHttpDecoder.getInstance());
    appResponse.when(success: (CollectModel model) {
      var size = model.datas?.length;
      debugPrint("成功返回$size条");
    }, failure: (String msg, int code) {
      debugPrint("失败了：$msg");
    });
  }

  /// 带缓存的 Get 请求
  void requestCacheGet() async {
    var response;
    var appResponse = await get<BannerModel, BannerModel>("banner/json",
        options: buildCacheOptions(const Duration(days: 7)),
        decodeType: BannerModel());
    appResponse.when(success: (BannerModel model) {
      var size = model.data?.length;
      debugPrint("成功返回$size条");
      response = model.toJson();
      debugPrint(response);
    }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
    });
  }

  /// 如果是特殊的数据格式，可以通过回调解析返回的请求
  void requestCallBack() async {
    var appResponse = await get<BannerModel, List<BannerBean>>("banner/json",
        options: buildCacheOptions(const Duration(days: 7)),
        decodeType: BannerModel(), converter: (response) {
      var errorCode = response.data['errorCode'];

      /// 请求成功
      if (errorCode == 0) {
        var data = response.data['data'];
        var dataList = List<BannerBean>.from(
            data.map((item) => BannerBean.fromJson(item)).toList());
        return Result.success(dataList);
      } else {
        var errorMsg = response.data['errorMsg'];
        return Result.failure(msg: errorMsg, code: errorCode);
      }
    });
    appResponse.when(success: (List<BannerBean> model) {
      for (var value in model) {
        debugPrint("~~~${value.title}");
      }
    }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
    });
  }
```



