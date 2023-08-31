import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 图片加载工具类
class ImageUtils {
  /// 加载本地资源图片
  static Widget loadAssetImage(String assetsUrl,
      {double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      assetsUrl,
      height: height,
      width: width,
      fit: fit,
    );
  }

  /// 加载网络图片, placeholder:占位图和加载失败时显示同一张图片
  static Widget loadNetworkImage(String imageUrl,
      {String placeholder = "none",
      double? width,
      double? height,
      BoxFit fit = BoxFit.cover}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          loadAssetImage(placeholder, height: height, width: width, fit: fit),
      errorWidget: (context, url, error) =>
          loadAssetImage(placeholder, height: height, width: width, fit: fit),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
