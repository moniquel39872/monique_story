import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/pages/exchange/exchange_view.dart';
import 'package:kombat_flutter/app/app_routes.dart';

class MyNavModel {
  static final Map<String, MyNavModel> urls = {};
  final IconData icon;
  final String name, url;
  final GetPageBuilder page;
  MyNavModel(this.name, this.icon, this.url, this.page) {
    urls[url] = this;
  }
}

class MainController extends GetxController {
  static MainController get to => Get.find();
  final selectedPath = exchangePath.obs;
  Widget getCurrentPage() {
    switch (selectedPath.value) {
      case exchangePath:
        return const ExchangePage();
      case settingsPath:
        return const SizedBox();
      case friendsPath:
        return const SizedBox();      
      case earnPath:
        return const SizedBox();
      case airDropPath:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }
}
