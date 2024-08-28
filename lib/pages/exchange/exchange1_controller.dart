import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/backpack_model.dart';
import 'package:kombat_flutter/model/exchange_model.dart';
import 'package:kombat_flutter/widget/app_toast.dart';

class ExchangeController extends GetxController {
  AppService appService = Get.find();
  RxList<ExchangeModel> exchangeList = RxList();
  RxList<BackpackModel> backpackList = RxList();
  RxBool isLoading = false.obs;

  Future<void> getExchanges() async {
    isLoading.value = true;
    AppToast.showLoading();
    NetBaseListEntity<ExchangeModel> data = await appService.httpClient.getExchange();
    AppToast.dismiss();
    isLoading.value = false;
    if(data.code==200) {
      exchangeList.value = data.data??[];
    } else {
      print(data.message);
    }
  }

  Future<bool> exchangeTrade(int eId, int gold) async {
    isLoading.value = true;
    AppToast.showLoading();
    NetBaseEntity<String> data = await appService.httpClient.exchangeTrade(eId);
    AppToast.dismiss();
    isLoading.value = false;
    if(data.data=='ok') {      
      appService.getMineInfo();
      return true;
    }
    return false;
  }

  Future<void> getBackpack() async {
    isLoading.value = true;
    AppToast.showLoading();
    NetBaseListEntity<BackpackModel> data = await appService.httpClient.getBackpack();
    AppToast.dismiss();
    isLoading.value = false;
    if(data.code==200) {
      backpackList.value = data.data??[];
    } else {
      print(data.message);
    }
  }

  Future<bool> withdrawal(int eId, String address) async {
    isLoading.value = true;
    AppToast.showLoading();
    NetBaseEntity<String> data = await appService.httpClient.withdrawal(eId, address);
    AppToast.dismiss();
    isLoading.value = false;
    if(data.data=='ok') {      
      appService.getMineInfo();
      return true;
    }
    return false;
  }

}
