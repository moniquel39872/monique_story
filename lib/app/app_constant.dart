import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/model/language_model.dart';
import 'package:kombat_flutter/model/main_tab.dart';

class AppConstant {
  static List<MainTabModel> mainTabs = [
    MainTabModel(
      code: "lottery",
      icon: "coin.png",
      label: "Home",
      navPath: lotteryPath,
    ),
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

  static List<LanguageModel> langs = [
    LanguageModel(
      code: "de",
      label: "Deutsch",
    ),
    LanguageModel(
      code: "en",
      label: "English",
    ),
    LanguageModel(
      code: "es",
      label: "Español",
    ),
    LanguageModel(
      code: "hi",
      label: "हिंदी(Hindi)",
    ),
    LanguageModel(
      code: "id",
      label: "Bahasa Indonesia",
    ),
    LanguageModel(
      code: "pt",
      label: "Português",
    ),
    LanguageModel(
      code: "ru",
      label: "Русский",
    ),
    LanguageModel(
      code: "th",
      label: "แบบไทย(Thai)",
    ),
    LanguageModel(
      code: "tr",
      label: "Türkçe",
    ),
    LanguageModel(
      code: "uz",
      label: "O'zbekcha",
    ),
    LanguageModel(
      code: "vi",
      label: "Tiếng Việt",
    ),
  ];
}
