import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/pages/splash/splash_controller.dart';
import 'package:kombat_flutter/utils/app_circle_progress_image.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value == false) {
          controller.onClose();
        }
        return Stack(children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: Center(
              child: AppImage.asset('splash.png'),
            ),
          ),
          Positioned(
            bottom: 140.w,
            left: MediaQuery.of(context).size.width / 2 - 100.w,
            child: SizedBox(
              width: 200.w,
              height: 200.w,
              child: Obx(() => AppCircularProgressIndicatorWithImage(
                value: controller.progressValue.value,
                duration: controller.duration.value,
              )),
            ),
          ),
          Positioned(
            bottom: -50.w,
            left: Get.width / 2 - 45.w,
            child: SizedBox(
              width: 200.w,
              height: 200.w,
              child: const Text("Loading...", style: TextStyle(fontSize: 20, 
                fontWeight: FontWeight.w700, color: Colors.white)
              ),
            ),
          ),          
        ]);
      })
    );
  }
}
