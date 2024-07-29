import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/pages/airdrop/airdrop_view.dart';
import 'package:kombat_flutter/pages/earn/earn_view.dart';
import 'package:kombat_flutter/pages/exchange/balance_view.dart';
import 'package:kombat_flutter/pages/exchange/exchange_view.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/pages/friends/friends_view.dart';
import 'package:kombat_flutter/pages/lottery/lottery_view.dart';
import 'package:kombat_flutter/pages/settings/profile_view.dart';
import 'package:kombat_flutter/pages/settings/select_language.dart';
import 'package:kombat_flutter/pages/settings/settings_view.dart';

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

  int scores = 0;
  RxBool isCipher = false.obs;
  RxString lang = "en".obs;

  final selectedPath = lotteryPath.obs;
  Widget getCurrentPage() {
    switch (selectedPath.value) {
      case lotteryPath:
        return const LotteryView();
      case exchangePath:
        return const ExchangePage();
      case settingsPath:
        return const SettingsView();
      case friendsPath:
        return const FriendsView();      
      case earnPath:
        return const EarnView();
      case airDropPath:
        return const AirdropView();
      case balancePath:
        return const BalanceView();
      case selectLangPath:
        return const SelectLanguageView();
      case profilePath:
        return const ProfileView();
      default:
        return const SizedBox();
    }
  }
  

}
