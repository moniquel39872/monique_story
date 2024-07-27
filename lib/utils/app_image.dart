import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImage {
  static Widget asset(String path,
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return Image.asset(
      'assets/images/$path',
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  static Widget network(
    String path, {
    double? width,
    double? height,
    BoxFit? fit,
    Widget? errorWidget,
  }) {
    Widget image;
    try {
      image = CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit,
        errorWidget: (c, s, o) {
          return errorWidget ??
              Container(
                color: Colors.transparent, //AppColors.xffF5F5F5(),
              );
        },
      );
    } catch (e) {
      image = errorWidget ??
          Container(color: Colors.transparent //AppColors.xffF5F5F5(),
              );
    }
    return image;
  }

  static Widget svgByAsset(String path,
      {double? width,
      double? height,
      Color? color,
      BoxFit fit = BoxFit.contain}) {
    return SvgPicture.asset(
      "assets/svg/$path",
      width: width,
      height: height,
      fit: fit,
      semanticsLabel: 'Acme Logo',
      colorFilter:
          color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget svgByAssetTransformed(String path,
      {double? width,
      double? height,
      Color? color,
      BoxFit fit = BoxFit.contain,
      double? angle}) {
    return Transform.rotate(
        angle: angle!, // radians equivalent to 180 degrees
        child: SvgPicture.asset(
          "assets/svg/$path",
          width: width,
          height: height,
          fit: fit,
          colorFilter:
              color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
        ));
  }
}
