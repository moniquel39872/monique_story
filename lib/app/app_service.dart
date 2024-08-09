import 'dart:convert';

import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_constant.dart';
import 'package:kombat_flutter/model/hotline_model.dart';
import 'package:kombat_flutter/model/language_model.dart';
import 'package:kombat_flutter/model/skin_model.dart';
import 'package:kombat_flutter/utils/app_logger.dart';
import 'package:kombat_flutter/utils/storage/index.dart';
import 'package:kombat_flutter/widget/app_json.dart';

class AppService extends GetxService{
  RxString curTab = "exchange".obs;
  RxString lang = "en".obs;
  RxString skin = "default".obs;  
  Rxn<HotlineModel> hotlineModel = Rxn();  
  Rx<Map<String, dynamic>> languageMap = Rx(<String, dynamic>{});
  Rx<Map<String, dynamic>> engLanguageMap = Rx(<String, dynamic>{});
  int scores = 0;    
  RxInt curCoins = 1000.obs;
  RxInt maxCoins = 1000.obs;
  Map<String, bool> firstLoad = {};
  String morseCode = "EHTM";

  Future<AppService> init() async {
    await Storage.instance.init();
    for(int i=0;i<AppConstant.mainTabs.length;i++){
      firstLoad[AppConstant.mainTabs[i].code] = true;
    }
    return this;
  }

  Future getHotlineStorageData() async {
    try {
      String hotlineString = Storage.instance.getString(StorageKey.HOTLINE_KEY);
      if (hotlineString == "") {
        hotlineModel.value = HotlineModel(
          lang: "en", 
          skin: "default"
        );
      } else {
        hotlineModel.value = HotlineModel.fromJson(jsonDecode(hotlineString));
        lang.value = hotlineModel.value?.lang ?? "en";
        skin.value = hotlineModel.value?.skin ?? "default";
      }
      // loadingIntercepter.value = true;
    } catch (e) {
      // loadingIntercepter.value = false;
      AppLogger.e('initAppNetData error = ', error: e);
    }
  }

  void setHotlineData() {
    hotlineModel.value?.lang = lang.value;
    hotlineModel.value?.skin = skin.value;
    Storage.instance
          .setString(StorageKey.HOTLINE_KEY, jsonEncode(hotlineModel.value));
  }

  Future<void> queryLanguageTrans() async {
    final data = await AppJSON.loadJsonObjFromAssets(
        'language/${getLanguageByCode(lang.value).shortName}.json');
    languageMap.value = data['title'] as Map<String, dynamic>;
    final engData =
        await AppJSON.loadJsonObjFromAssets('language/en_US.json');
    engLanguageMap.value = engData['title'] as Map<String, dynamic>;
  }

  String getTrans(String key, {List<String>? params}) {
    String result = key;
    if (languageMap.value[key] != null) {
      result = languageMap.value[key].toString();
    } else if (engLanguageMap.value[key] != null) {
      result = engLanguageMap.value[key].toString();
    } 
    if(params!=null) {
      for(int i=0;i<params.length;i++) {
        result = result.replaceFirst('%s', params[i]);
      }
    }
    return result;
  }

  LanguageModel getLanguageByCode(String code) {
    int index = AppConstant.langs.indexWhere((item)=>item.code==code);
    if(index<0) {
      return AppConstant.langs[0];
    } else {
      return AppConstant.langs[index];
    }
  }

  SkinModel getSkinByCode(String code) {
    int index = AppConstant.skins.indexWhere((item)=>item.code==code);
    if(index<0) {
      return AppConstant.skins[0];
    } else {
      return AppConstant.skins[index];
    }
  }
}