import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/mine_info_model.dart';
import 'package:kombat_flutter/model/morse_code_model.dart';
import 'package:kombat_flutter/model/token_model.dart';
import 'package:kombat_flutter/model/user_info_model.dart';
import 'package:kombat_flutter/widget/app_toast.dart';

class LotteryController extends GetxController {
  AppService appService = Get.find();

  Future<void> signIn() async {
    AppToast.showLoading(msg: appService.getTrans('Sign in...'));
    String walletAddress = appService.walletAddress;
    NetBaseEntity<TokenModel> data = await appService.httpClient.signIn(walletAddress);
    AppToast.dismiss();
    if(data.code==200) {
      appService.isLogin.value = true;
      appService.tokenModel.value = data.data;
      await getMorseCode();
    } else {
      appService.isLogin.value = false;
      appService.tokenModel.value = null;
      AppToast.showToast(data.message);
    }
  }

  Future<void> getMorseCode() async {
    NetBaseEntity<MorseCodeModel> data = await appService.httpClient.getMorseCode();
    if(data.code==200) {
      appService.morseCode = data.data?.letters??"";      
    } else {
      appService.morseCode = "";
      // AppToast.showToast(data.message);
      print(data.message);
    }
  }
}