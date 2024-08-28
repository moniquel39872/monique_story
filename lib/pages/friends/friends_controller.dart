import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/friend_model.dart';
import 'package:kombat_flutter/model/order_model.dart';
import 'package:kombat_flutter/widget/app_toast.dart';

class FriendsController extends GetxController {
  AppService appService = Get.find();
  RxList<FriendModel> friendsList = RxList();
  RxBool isLoading = false.obs;

  Future<void> getFriends() async {
    isLoading.value = true;
    AppToast.showLoading();
    NetBaseListEntity<FriendModel> data = await appService.httpClient.getFriends();
    AppToast.dismiss();
    isLoading.value = false;
    if(data.code==200) {
      friendsList.value = data.data??[];
    } else {
      AppToast.showToast(data.message);      
    }
  }
}
