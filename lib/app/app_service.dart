import 'package:get/get.dart';
import 'package:kombat_flutter/utils/storage/index.dart';

class AppService extends GetxService{
  RxString curTab = "exchange".obs;

  Future<AppService> init() async {
    await Storage.instance.init();
    
    return this;
  }
}