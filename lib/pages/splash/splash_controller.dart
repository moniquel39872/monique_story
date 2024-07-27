import 'dart:async';

import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_navigator.dart';
import 'package:kombat_flutter/app/app_routes.dart';

class SplashController extends GetxController {
  RxInt progressValue = 0.obs;
  RxInt duration = 0.obs;
  RxBool isLoading = true.obs;

    @override
  void onReady() {
    super.onReady();
    initServices();
  }

  Future initServices() async {
    // appServer.checkVersion("h5", "Android");
    try {
        Timer timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
          if (progressValue.value < 100) {
            progressValue.value += 5;
          } else {
            progressValue.value = 100;
            timer.cancel();
          }
        });
        await Future.delayed(const Duration(milliseconds: 1500));
        AppNavigator.offAllNamed(homePath);     
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    super.onClose();    
  }
}