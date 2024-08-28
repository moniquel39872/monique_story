import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/game_prize_model.dart';
import 'package:kombat_flutter/model/home_game_model.dart';
import 'package:kombat_flutter/model/prize_result_model.dart';
import 'package:kombat_flutter/model/recharge_model.dart';
import 'package:kombat_flutter/widget/app_toast.dart';

class LotteryController extends GetxController {
  AppService appService = Get.find();
  List<String> curItemLabel = ["Connect Wallet", "Order", "Lucky Time", "Earn"];
  RxInt selectedIndex = 0.obs;
  Rxn<HomeGameModel> homeGame = Rxn();
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController rechargeEditingController = TextEditingController();

  Future<bool> recharge() async {
    AppToast.showLoading();
    NetBaseEntity<RechargeModel> data = await appService.httpClient.recharge();
    AppToast.dismiss();
    if(data.code==200) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> getHomeGame() async {
    AppToast.showLoading();
    NetBaseEntity<HomeGameModel> data = await appService.httpClient.getHomeGame();
    AppToast.dismiss();
    if(data.code==200) {
      homeGame.value = data.data!;
      int cnt = (homeGame.value?.data??[]).length;
      if(cnt<6) {
        return -1; //not yet placed 6 orders
      } else {
        for(int i=0;i<cnt;i++) {
          GamePrizeModel item = homeGame.value?.data![i]??GamePrizeModel();
          if(item.fast==1 && item.status==1) {
            return 1; //winning
          }
        }
        return 0; //failed
      }
    }
    return -1;
  }

  Future<bool> checkPrize(int prizeId) async {
    AppToast.showLoading();
    NetBaseEntity<PrizeResultModel> data = await appService.httpClient.checkPrize(prizeId);
    AppToast.dismiss();
    if(data.code==200) {
      return true;
    } else {
      return false;
    }
  }
}
