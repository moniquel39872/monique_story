import 'dart:ui';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/order_log_model.dart';
import 'package:kombat_flutter/model/order_model.dart';
import 'package:kombat_flutter/pages/earn/models/my_earning_tab.dart';
import 'package:kombat_flutter/widget/app_toast.dart';

class EarnController extends GetxController {
  final AppService appService = Get.find();
  Rxn<OrderListModel> orderList = Rxn();
  Rxn<OrderLogListModel> orderLogList0 = Rxn();
  RxList<OrderLogModel> orderLogs = RxList();
  RxBool isLoading1 = false.obs;
  RxBool isLoading2 = false.obs;
  RxInt earningIndex = 0.obs;

  RxList<MyEarningTab> myEarningTabs = [
    MyEarningTab(
      id: 0,
      label: 'Total Revenue',
      icon: 'earn/total_revenue.png',
      price: '0.00',
    ),
    MyEarningTab(
      id: 1,
      label: 'Dividend income',
      icon: 'earn/money_growth.png',
      price: '0.00',
    ),
    MyEarningTab(
      id: 2,
      label: 'Burn gains',
      icon: 'earn/financial_loss.png',
      price: '0.00',
    ),
  ].obs;

  @override
  void onReady() {
    myEarningTabs.value = [
      MyEarningTab(
        id: 0,
        label: 'Total Revenue',
        icon: 'earn/total_revenue.png',
        price: double.parse(
                appService.mineInfoModel.value?.withdrawTotal ?? "0.00")
            .toStringAsFixed(2),
      ),
      MyEarningTab(
        id: 1,
        label: 'Dividend income',
        icon: 'earn/money_growth.png',
        price: getDividendIncome(),
      ),
      MyEarningTab(
        id: 2,
        label: 'Burn gains',
        icon: 'earn/financial_loss.png',
        price:
            double.parse(appService.mineInfoModel.value?.invitTotal ?? "0.00")
                .toStringAsFixed(2),
      ),
    ];
    super.onReady();
  }

  String getDividendIncome() {
    double t =
        double.parse(appService.mineInfoModel.value?.withdrawTotal ?? "0.00");
    double b =
        double.parse(appService.mineInfoModel.value?.invitTotal ?? "0.00");
    return (t - b).toStringAsFixed(2);
  }

  Future<void> getOrderList() async {
    isLoading1.value = true;
    AppToast.showLoading();
    NetBaseEntity<OrderListModel> data =
        await appService.httpClient.getOrderList();
    AppToast.dismiss();
    isLoading1.value = false;
    if (data.code == 200) {
      orderList.value = data.data;
    } else {
      print(data.message);
    }
  }

  Future<void> getOrderLogList() async {
    isLoading2.value = true;
    AppToast.showLoading();
    NetBaseEntity<OrderLogListModel> data =
        await appService.httpClient.getOrderLogList(1);
    AppToast.dismiss();
    isLoading2.value = false;
    if (data.code == 200) {
      orderLogList0.value = data.data;
      chooseOrderLogs();
    } else {
      print(data.message);
    }
  }

  void chooseOrderLogs() {
    if (earningIndex.value == 0) {
      orderLogs.value = orderLogList0.value?.data ?? [];
    } else if (earningIndex.value == 1) {
      orderLogs.value = (orderLogList0.value?.data ?? [])
          .where((item) => item.type > 1)
          .toList();
    } else {
      orderLogs.value = (orderLogList0.value?.data ?? [])
          .where((item) => item.type == 1)
          .toList();
    }
  }

  String getOrderTotal(OrderModel order) {
    if(order.fast==-1 || order.fast == 2) {
      return '0';
    } else {
      return (1.5 * double.parse(order.orderAmount)).toStringAsFixed(4);
    }
  }

  String getOutAmount(OrderModel order) {
    double a = double.parse(order.outAmount);
    if(a>0) {
      return a.toStringAsFixed(4);
    }
    return '0';
  }

  Color getOrderTotalColor(OrderModel order) {
    if(order.fast == -1) {
      return const Color(0xff333333);
    } else if(order.fast == 2) {
      return const Color(0xff4f4ce8);
    } else {
      return const Color(0xff9e473b);
    }
  }

  double getProgressValue(OrderModel order) {
    return (double.parse(order.outAmount)/double.parse(order.outTotal))*100;
  }
}
