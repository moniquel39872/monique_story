import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

@immutable
class AppPositionedBackground extends StatelessWidget {
  double? top;
  double? left;
  double? bottom;
  double? right;
  double? height;
  String assetPath;
  
  AppPositionedBackground({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.height,
    required this.assetPath
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: top?.h, left: left?.w, bottom: bottom?.h, right: right?.w,
      child: Container(
        width: Get.width, height: height?.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/$assetPath'),
            fit: BoxFit.fitWidth
          ) 
        ),
      )
    );
  }
}