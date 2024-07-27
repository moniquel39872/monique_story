import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/widget/app_positioned_background.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppPositionedBackground(assetPath: 'gradient1.png', top: -80, left: 0, height: 400),
          AppPositionedBackground(assetPath: 'back1.png', top: 80, left: 0, height: Get.height+300),          
        ],
      )
    );
  }
}