import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/model/main_tab.dart';

class AppConstant {
  static List<MainTabModel> mainTabs = [
    MainTabModel(
      code: "exchange",
      icon: "avatar0.png",
      label: "Exchange",
      navPath: exchangePath,
    ),
    MainTabModel(
      code: "friends",
      icon: "friends.png",
      label: "Friends",
      navPath: friendsPath,
    ),
    MainTabModel(
      code: "earn",
      icon: "earn.png",
      label: "Earn",
      navPath: earnPath,
    ),
    MainTabModel(
      code: "airdrop",
      icon: "airdrop.png",
      label: "Airdrop",
      navPath: airDropPath,
    ),
  ];
}
