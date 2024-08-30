import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_constant.dart';
import 'package:kombat_flutter/errors/mixins/api_handler.dart';
import 'package:kombat_flutter/http/app_http_client.dart';
import 'package:kombat_flutter/http/app_http_core.dart';
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/hotline_model.dart';
import 'package:kombat_flutter/model/language_model.dart';
import 'package:kombat_flutter/model/mine_info_model.dart';
import 'package:kombat_flutter/model/morse_code_model.dart';
import 'package:kombat_flutter/model/token_model.dart';
import 'package:kombat_flutter/model/user_info_model.dart';
import 'package:kombat_flutter/model/skin_model.dart';
import 'package:kombat_flutter/utils/app_logger.dart';
import 'package:kombat_flutter/utils/storage/index.dart';
import 'package:kombat_flutter/widget/app_json.dart';
import 'package:http/http.dart' as http;
import 'package:kombat_flutter/widget/app_toast.dart';
import 'package:vibration/vibration.dart';

class AppService extends GetxService with ApiHandler {
  final String walletAddress = '9JvVRpmUPGkSqwtbwCPw2QvRX2EmNbRhjAaa5muqdakz';  

  late AppHttpClient httpClient;

  int maxMultitouchNumber = 4;
  RxString curTab = "lottery".obs;
  RxString currentLang = "en".obs;
  RxString currentSkin = "default".obs;  
  RxBool showGuide = true.obs;
  Rxn<HotlineModel> hotlineModel = Rxn();  
  Rx<Map<String, dynamic>> languageMap = Rx(<String, dynamic>{});
  Rx<Map<String, dynamic>> engLanguageMap = Rx(<String, dynamic>{});
  Map<String, bool> firstLoad = {};
  String morseCode = "";
  RxInt morseCodeGolds = 10000.obs;
  int initEarnTabIndex = 0;
  RxInt increasedGolds = 0.obs;
  RxBool isLogin = false.obs;
  RxString countryCode = "RU".obs;
  RxInt dailyGolds = 0.obs;

  Rxn<TokenModel> tokenModel = Rxn();
  /// 登录信息
  Rxn<UserInfoModel> userInfoModel = Rxn();
  Rxn<MineInfoModel> mineInfoModel = Rxn();
    ///设备信息
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidDeviceInfo;
  IosDeviceInfo? iosDeviceInfo;
  //ScafoldContext
  BuildContext? context;
  RxBool loadingIntercepter = false.obs;  
  static Function toastResult = (){};

  Future<AppService> init() async {
    await Storage.instance.init();
    isLogin.value = false;
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        androidDeviceInfo = await deviceInfo.androidInfo;
      }

      if (Platform.isIOS) {
        iosDeviceInfo = await deviceInfo.iosInfo;
      }
    }
    // try {
    //   await getCountryPhoneCode();
    // } catch (e) {}

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
          skin: "default",
          showGuide: true
        );
      } else {
        hotlineModel.value = HotlineModel.fromJson(jsonDecode(hotlineString));
        currentLang.value = hotlineModel.value?.lang ?? "en";
        currentSkin.value = hotlineModel.value?.skin ?? "default";
        showGuide.value = hotlineModel.value?.showGuide ?? true;
      }
      // loadingIntercepter.value = true;
    } catch (e) {
      // loadingIntercepter.value = false;
      AppLogger.e('initAppNetData error = ', error: e);
    }
  }

  void setHotlineData() {
    hotlineModel.value?.lang = currentLang.value;
    hotlineModel.value?.skin = currentSkin.value;
    hotlineModel.value?.showGuide = showGuide.value;
    Storage.instance
          .setString(StorageKey.HOTLINE_KEY, jsonEncode(hotlineModel.value));
  }

  void setLanguage(String code) async {
    currentLang.value=code;
    setHotlineData();
    await queryLanguageTrans();
  }

  Future setHttpInterceptor() async {
    try {
      httpClient =
          AppHttpClient(AppHttpCore(baseUrl: AppConstant.getBaseUrl()).dio);
    } catch (e) {
      loadingIntercepter.value = false;
    }
  }

  String getDeviceId() {
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        return androidDeviceInfo?.id ?? 'null';
      }
      if (Platform.isIOS) {
        return iosDeviceInfo?.identifierForVendor ?? 'null';
      }
      return 'null';
    } else {
      return 'null';
    }
  }

  String getDeviceModel() {
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        return androidDeviceInfo?.model ?? 'null';
      }
      if (Platform.isIOS) {
        return iosDeviceInfo?.model ?? 'null';
      }
      return 'null';
    } else {
      return 'null';
    }
  }

  Future<String> getCountryPhoneCode() async {
    var response = await http.get(Uri.parse('http://ip-api.com/json'));
    var jsonResponse = json.decode(response.body);
    final isoCode = jsonResponse['countryCode'];
    countryCode.value = isoCode;
    return isoCode;
  }

  Future<void> queryLanguageTrans() async {
    final data = await AppJSON.loadJsonObjFromAssets(
        'language/${getLanguageByCode(currentLang.value).shortName}.json');
    languageMap.value = data['title'] as Map<String, dynamic>;
    final engData = currentLang.value=='en' ? data :
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

  SkinModel getSkinById(int id) {
    int index = AppConstant.skins.indexWhere((item)=>item.id==id);
    if(index<0) {
      return AppConstant.skins[0];
    } else {
      return AppConstant.skins[index];
    }
  }

  SkinModel getSkinByPrice(int price) {
    return AppConstant.skins.lastWhere((item)=>item.price!<=price);    
  }

  Future<void> setCheckAutoLogin(bool value) async {
    Storage.instance.setBool(StorageKey.CHECKAUTOLOGIN, value);
  }

    /// 登出
  Future onLogOut() async {
    // if (isLogin.value) {
    //   await httpClient.logout();
    // }
    setCheckAutoLogin(false);
    tokenModel.value = null;
    userInfoModel.value = null;
    isLogin.value = false;
  }

  Future<void> getMineInfo() async {
    AppToast.showLoading();
    NetBaseEntity<MineInfoModel> data = await httpClient.getMineInfo();
    AppToast.dismiss();
    if(data.code==200) {
      mineInfoModel.value = data.data;
      setLanguage(data.data?.lang??"en");
      dailyGolds.value = data.data?.dailyGoldsLimit??0;
    } else {
      mineInfoModel.value = null;
      AppToast.showToast(data.message);      
    }
  }

  bool checkIfIncreaseDailyGolds(){
    if(mineInfoModel.value==null) {
      return false;
    }
    int g = mineInfoModel.value?.gold??0 + increasedGolds.value;
    int limit = int.parse(mineInfoModel.value?.dailyGoldsLimit??"0");
    return g<limit;
  }

  int getDialyGolds() {
    int d = mineInfoModel.value?.dailyGolds??0; 
    return d + increasedGolds.value;
  }

  int getCurrentGolds() {
    int d = mineInfoModel.value?.gold??0; 
    return d + increasedGolds.value;
  }

  void updateCurrentGolds(int val) {
    int d = mineInfoModel.value?.gold??0; 
    mineInfoModel.value?.gold = d + val;
  }

  double getLevelPercent() {
    int l = mineInfoModel.value?.level??1;
    int m = mineInfoModel.value?.maxLevel??18;
    return (l/m * 100);
  }

  int getCurLevel() {
    if(mineInfoModel.value!=null) {
      return mineInfoModel.value?.level??1;
    }
    return 1;
  }

  Future<void> signIn(String wallet) async {
    AppToast.showLoading();
    NetBaseEntity<TokenModel> data = await httpClient.signIn(wallet);
    AppToast.dismiss();
    if(data.code==200) {
      isLogin.value = true;
      tokenModel.value = data.data;
      await getMorseCode();
    } else {
      isLogin.value = false;
      tokenModel.value = null;
      AppToast.showToast(data.message);
    }
  }

  Future<void> getMorseCode() async {
    NetBaseEntity<MorseCodeModel> data = await httpClient.getMorseCode();
    if(data.code==200) {
      morseCode = data.data?.letters??"";      
    } else {
      morseCode = "";
      AppToast.showToast(data.message);
    }
  }

  Future<void> vibrate() async {
    //Vibration
    // HapticFeedback.heavyImpact();
    // bool hasVibrator = await Vibration.hasVibrator()??false;
    // if (hasVibrator) {
      Vibration.vibrate();
    // }
  }
}