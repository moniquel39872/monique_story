import 'package:kombat_flutter/model/main_tab.dart';

class AppConstant{
  static List<MainTabModel> mainTabs = [
    MainTabModel(code: "exchange", icon: "avatar0.png", label: "Exchange"),
    MainTabModel(code: "friends", icon: "friends.png", label: "Friends"),
    MainTabModel(code: "earn", icon: "earn.png", label: "Earn"),
    MainTabModel(code: "airdrop", icon: "airdrop.png", label: "Airdrop"),
  ];
}