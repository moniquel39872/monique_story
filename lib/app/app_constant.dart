import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/model/language_model.dart';
import 'package:kombat_flutter/model/main_tab.dart';
import 'package:kombat_flutter/model/skin_model.dart';

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

  static List<SkinModel> skins = [
    SkinModel(code: "default", icon:"default.png", label: "Default", type: "", desc: "Your league's default skin", price:0),
    SkinModel(code: "marta", icon:"marta.png", label: "Marta", type:"Legendary", 
      desc: "Marta is the kind-hearted hamster who loves helping others and always has a warm smile for everyone", price: 2500000),
    SkinModel(code: "homie", icon:"homie.png", label: "Homie", type:"Legendary",
      desc:"Homie is the loyal friend who enjoys spending time with his buddies and always knows how to make everyone feel at home", price: 2500000),
    SkinModel(code: "fighty", icon:"fighty.png", label: "Fighty", type:"Legendary", 
      desc:"Fighty is full of enerfy and enthusiasm, always up for a fun adventure or a new game with friends", price: 2500000),
    SkinModel(code: "rockstar", icon:"rockstar.png", label: "Rockstar", type:"Legendary",
      desc:"Rockstar loves music and is always ready to play a tune or sing a song to lift everyones's spirits", price: 2500000),
    SkinModel(code: "fanky", icon:"fanky.png", label: "Fanky", type: "Master",
      desc: "Fanky si the live of the party, bringing joy and laughter with funky dance moves and a great sense of humor", price: 10000000),
    SkinModel(code: "punky", icon:"punky.png", label: "Punky", type: "Master",
      desc: "Punky is cool and edgy, with a unique style and a knack for turning heads wherever they go", price: 10000000),
    SkinModel(code: "groovy", icon:"groovy.png", label: "Groovy", type: "Master", 
      desc:"Groovy is smooth and stylish, always on top of the latest trends and loves to spread good vibes", price: 10000000),
    SkinModel(code: "funny", icon:"funny.png", label: "Funny", type: "Master", 
      desc: "Funny is the comedian of the group, always making everyone laugh with jokes and playful antics", price: 10000000),
    SkinModel(code: "hamstervestor", icon:"hamstervestor.png", label: "Hamstervestor", type: "GrandMaster", 
      desc: "Hamstervestor is the entrepreneurial spirit, always coming up with new ideas and ways to make things better for everyone", price: 50000000),
    SkinModel(code: "busy", icon:"busy.png", label: "Busy", type: "Grandmaster", 
      desc: "Busy is always active and loves staying productive, whether organizing events or helping friends with their tasks", price: 50000000),
    SkinModel(code: "smarty", icon:"smarty.png", label: "Smarty", type: "Grandmaster", 
      desc: "Smarty loves learning and sharing knowledge, always curious and dager to explore new topics and ideas", price: 100000000),
    SkinModel(code: "spacy", icon:"spacy.png", label: "Spacy", type: "Grandmaster", 
      desc: "Spacy is the adventurous astronaut who loves exploring the far reaches of the galaxy, always dreaming of new planets to visit and stars to study", price: 50000000),
    SkinModel(code: "bravy", icon:"bravy.png", label: "Bravy", type: "Grandmaster", 
      desc: "Bravy is courageous an inspiring, always encouraging friends to try new things and be their best selves", price: 50000000),
    SkinModel(code: "genius", icon:"genius.png", label: "Genius", type: "Lord", 
      desc: "Genius is incredibly smart and inventive, always tinkering with new projects and solving puzzles", price: 200000000),
    SkinModel(code: "wisy", icon:"wisy.png", label: "Wisy", type: "Lord", 
      desc: "Wisy is wise and thoughtful, offering great advice and guidance to friends in need", price: 500000000),
    SkinModel(code: "gravity", icon:"gravity.png", label: "Gravity", type: "Lord", 
      desc: "Gravity is the expert on all things realted to the forces of space, keeping everyone grounded with a deep understanding of how the universe holds together", price: 200000000),
    SkinModel(code: "appolo", icon:"appolo.png", label: "Appolo", type: "Lord", 
      desc: "Appolo is the mission commander with a passion for space exploration and discovery, always ready to lead the crew on exciting interstellar joumeys", price: 200000000),
  ];
}
