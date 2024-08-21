
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/order_log_model.dart';
import 'package:kombat_flutter/model/order_model.dart';
import 'package:kombat_flutter/widget/app_toast.dart';

class EarnController extends GetxController {
  AppService appService = Get.find();
  Rxn<OrderListModel> orderList = Rxn();
  Rxn<OrderLogListModel> orderLogList0 = Rxn();
  RxList<OrderLogModel> orderLogs = RxList();
  RxBool isLoading1 = false.obs;
  RxBool isLoading2 = false.obs;
  RxInt earningIndex = 0.obs;

  String getDividendIncome() {
    double t = double.parse(appService.mineInfoModel.value?.withdrawTotal??"0.00");
    double b = double.parse(appService.mineInfoModel.value?.invitTotal??"0.00");
    return (t-b).toStringAsFixed(2);
  }

  Future<void> getOrderList() async {
    isLoading1.value = true;
    AppToast.showLoading(msg: appService.getTrans('Request processing...'));
    NetBaseEntity<OrderListModel> data = await appService.httpClient.getOrderList();
    AppToast.dismiss();
    isLoading1.value = false;
    if(data.code==200) {
      orderList.value = data.data;
    } else {
      print(data.message);
    }
  }

  Future<void> getOrderLogList() async {
    isLoading2.value = true;
    AppToast.showLoading(msg: appService.getTrans('Request processing...'));
    NetBaseEntity<OrderLogListModel> data = await appService.httpClient.getOrderLogList(1);
    AppToast.dismiss();
    isLoading2.value = false;
    if(data.code==200) {
      orderLogList0.value = data.data;
      chooseOrderLogs();
    } else {
      print(data.message);
    }
  }

  void chooseOrderLogs() {
    if(earningIndex.value==0) {
      orderLogs.value = orderLogList0.value?.data??[];
    } else if(earningIndex.value==1) {
      orderLogs.value = (orderLogList0.value?.data??[]).where((item)=>item.type>1).toList();
    } else {
      orderLogs.value = (orderLogList0.value?.data??[]).where((item)=>item.type==1).toList();
    }
  }
}
