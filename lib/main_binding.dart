import 'package:get/get.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    // Get.lazyPut(() => AuthController()); // Initialize AuthController globally
    // You can put other bindings here
  }
}