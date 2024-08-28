import 'package:flutter/foundation.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/model/earn_item_model.dart';
import 'package:kombat_flutter/model/language_model.dart';
import 'package:kombat_flutter/model/main_tab.dart';
import 'package:kombat_flutter/model/skin_model.dart';

class AppConstant {
  static const _debugBaseUrl =
      "https://api.walletconnect8.com";
  
  static const _releaseBaseUrl =
      "https://api.walletconnect8.com";
      
  /// 获取运行环境是否是正式环境
  static bool getRunEnvIsRelease() {
    return kReleaseMode;
  }

  /// 返回服务器运行环境
  static String getBaseUrl() {
    if (getRunEnvIsRelease()) {
      return _releaseBaseUrl;
    }
    return _debugBaseUrl;
  }

  static List<MainTabModel> mainTabs = [
    MainTabModel(
      code: "playground",
      icon: "playground",
      label: "Playground",
      navPath: lotteryPath,
    ),
    MainTabModel(
      code: "mine",
      icon: "mine",
      label: "Mine",
      navPath: minePath,
    ),
    MainTabModel(
      code: "friends",
      icon: "friends",
      label: "Friends",
      navPath: friendsPath,
    ),
    MainTabModel(
      code: "earn",
      icon: "earn",
      label: "Earn",
      navPath: earnPath,
    ),
    MainTabModel(
      code: "exchange",
      icon: "exchange",
      label: "Exchange",
      navPath: exchangePath,
    ),    
  ];

  static List<LanguageModel> langs = [
    LanguageModel(code: "de", name: "Deutsch", shortName: 'de_De'),
    LanguageModel(code: "en", name: "English", shortName: 'en_US'),
    LanguageModel(code: "es", name: "Español", shortName: 'es_ES'),
    LanguageModel(code: "hi", name: "हिंदी(Hindi)", shortName: 'hi_IN'),
    LanguageModel(code: "id", name: "Bahasa Indonesia", shortName: 'id_ID'),
    LanguageModel(code: "pt", name: "Português", shortName: 'pt_PT'),
    LanguageModel(code: "ru", name: "Русский", shortName: 'ru_RU'),
    LanguageModel(code: "th", name: "แบบไทย(Thai)", shortName: 'th_TH'),
    LanguageModel(code: "tr", name: "Türkçe", shortName: 'tr_TR'),
    LanguageModel(code: "uz", name: "O'zbekcha", shortName: 'uz_UZ'),
    LanguageModel(code: "vi", name: "Tiếng Việt", shortName: 'vi_VN'),
    LanguageModel(code: "cn", name: "简体中文", shortName: 'zh_CN'),
    LanguageModel(code: "tw", name: "繁體中文", shortName: 'zh_TW'),
  ];

  static List<SkinModel> skins = [
    SkinModel(id: 1, code: "default", icon:"default.png", label: "Default", type: "", desc: "That's default skin", price:0),
    SkinModel(id: 2, code: "marta", icon:"marta.png", label: "Marta", type:"Legendary", 
      desc: "Marta is the kind-hearted hamster who loves helping others and always has a warm smile for everyone", price: 2500000),
    SkinModel(id: 3, code: "homie", icon:"homie.png", label: "Homie", type:"Legendary",
      desc:"Homie is the loyal friend who enjoys spending time with his buddies and always knows how to make everyone feel at home", price: 2500000),
    SkinModel(id: 4, code: "fighty", icon:"fighty.png", label: "Fighty", type:"Legendary", 
      desc:"Fighty is full of energy and enthusiasm, always up for a fun adventure or a new game with friends", price: 2500000),
    SkinModel(id: 5, code: "rockstar", icon:"rockstar.png", label: "Rockstar", type:"Legendary",
      desc:"Rockstar loves music and is always ready to play a tune or sing a song to lift everyone's spirits", price: 2500000),
    SkinModel(id: 6, code: "fanky", icon:"fanky.png", label: "Fanky", type: "Master",
      desc: "Fanky is the life of the party, bringing joy and laughter with funky dance moves and a great sense of humor", price: 10000000),
    SkinModel(id: 7, code: "punky", icon:"punky.png", label: "Punky", type: "Master",
      desc: "Punky is cool and edgy, with a unique style and a knack for turning heads wherever they go", price: 10000000),
    SkinModel(id: 8, code: "groovy", icon:"groovy.png", label: "Groovy", type: "Master", 
      desc:"Groovy is smooth and stylish, always on top of the latest trends and loves to spread good vibes", price: 10000000),
    SkinModel(id: 9, code: "funny", icon:"funny.png", label: "Funny", type: "Master", 
      desc: "Funny is the comedian of the group, always making everyone laugh with jokes and playful antics", price: 10000000),
    SkinModel(id: 10, code: "hamstervestor", icon:"hamstervestor.png", label: "Hamstervestor", type: "Grandmaster", 
      desc: "Hamstervestor is the entrepreneurial spirit, always coming up with new ideas and ways to make things better for everyone", price: 50000000),
    SkinModel(id: 11, code: "busy", icon:"busy.png", label: "Busy", type: "Grandmaster", 
      desc: "Busy is always active and loves staying productive, whether organizing events or helping friends with their tasks", price: 50000000),
    SkinModel(id: 12, code: "smarty", icon:"smarty.png", label: "Smarty", type: "Grandmaster", 
      desc: "Smarty loves learning and sharing knowledge, always curious and eager to explore new topics and ideas", price: 100000000),
    SkinModel(id: 13, code: "spacy", icon:"spacy.png", label: "Spacy", type: "Grandmaster", 
      desc: "Spacy is the adventurous astronaut who loves exploring the far reaches of the galaxy, always dreaming of new planets to visit and stars to study", price: 50000000),
    SkinModel(id: 14, code: "bravy", icon:"bravy.png", label: "Bravy", type: "Grandmaster", 
      desc: "Bravy is courageous and inspiring, always encouraging friends to try new things and be their best selves", price: 50000000),
    SkinModel(id: 15, code: "genius", icon:"genius.png", label: "Genius", type: "Lord", 
      desc: "Genius is incredibly smart and inventive, always tinkering with new projects and solving puzzles", price: 200000000),
    SkinModel(id: 16, code: "wisy", icon:"wisy.png", label: "Wisy", type: "Lord", 
      desc: "Wisy is wise and thoughtful, offering great advice and guidance to friends in need", price: 500000000),
    SkinModel(id: 17, code: "gravity", icon:"gravity.png", label: "Gravity", type: "Lord", 
      desc: "Gravity is the expert on all things related to the forces of space, keeping everyone grounded with a deep understanding of how the universe holds together", price: 200000000),
    SkinModel(id: 18, code: "appolo", icon:"appolo.png", label: "Appolo", type: "Lord", 
      desc: "Appolo is the mission commander with a passion for space exploration and discovery, always ready to lead the crew on exciting interstellar journeys", price: 200000000),
  ];

  static List<EarnItemModel> earns = [
    EarnItemModel(id: '1', title: 'Dividend', prize: -0.5, date: '2024-07-08'),
    EarnItemModel(id: '2', title: 'Dividend', prize: 0.5, date: '2024-07-08'),
    EarnItemModel(id: '3', title: 'Dividend', prize: 1.5, date: '2024-07-08'),
    EarnItemModel(id: '4', title: 'Burn gains', prize: -1.5, date: '2024-07-08'),
    EarnItemModel(id: '5', title: 'Dividend', prize: -2.5, date: '2024-07-08'),
    EarnItemModel(id: '6', title: 'Burn gains', prize: 1.5, date: '2024-07-08'),
    EarnItemModel(id: '7', title: 'Dividend', prize: -0.5, date: '2024-07-08'),
  ];
}
