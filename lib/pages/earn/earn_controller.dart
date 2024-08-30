import 'dart:ui';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/chart_data_model.dart';
import 'package:kombat_flutter/model/order_log_model.dart';
import 'package:kombat_flutter/model/order_model.dart';
import 'package:kombat_flutter/pages/earn/models/my_earning_tab.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_date_util.dart';
import 'package:kombat_flutter/widget/app_toast.dart';

class EarnController extends GetxController {
  final AppService appService = Get.find();
  Rxn<OrderListModel> orderList = Rxn();
  Rxn<OrderLogListModel> orderLogList0 = Rxn();
  RxList<OrderLogModel> orderLogs = RxList();
  RxBool isLoading1 = false.obs;
  RxBool isLoading2 = false.obs;
  RxInt earningIndex = 0.obs;
  RxList<String> dates = RxList();
  RxInt selectedDateIndex = 0.obs;
  Rx<LineChartBarData> lineChartBarData = LineChartBarData().obs;
  List<FlSpot> flSpots = [];
  List<int> curDateIndexs = [];
  RxList<ChartDataModel> chartDataList = RxList();
  int curPageOrders = 1;

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

  void init() {
    orderList = Rxn();
    orderLogList0 = Rxn();
    orderLogs = RxList();
    earningIndex = 0.obs;
    dates = RxList();
    selectedDateIndex = 0.obs;
    lineChartBarData = LineChartBarData().obs;
    flSpots = [];
    curDateIndexs = [];
    chartDataList = RxList();
    getOrderList(1);
    getOrderLogList(1);
    getEarnDates();
    getChartDataList(7);  
  }

  void getEarnDates({bool isWeekDates=true}) {        
    if(isWeekDates){
      curDateIndexs = [];
      dates.value = AppDateUtil.getWeekDates();      
    } else {
      dates.value = AppDateUtil.getMonthDates();
    }

    for(int i=0;i<dates.length;i++) {      
      if(dates[i]==AppDateUtil.curDate()) {
        selectedDateIndex.value = i;        
      }
      if(isWeekDates) {
        curDateIndexs.add(i);
      }
    }
  }

  void setCurDateIndexes(List<int> indexes) {
    curDateIndexs = indexes;
  }

  void getChartData() {
    flSpots = [];
    int preDay = 0;
    for(int i=0;i<chartDataList.length;i++) {
      double x=0, y=0;      
      int day = AppDateUtil.getDay(chartDataList[i].date);
      if(day<preDay) {
        preDay++;
        x = preDay.toDouble();
      } else {
        x = day.toDouble();
        preDay = day;
      }
      y = chartDataList[i].total.toDouble();
      flSpots.add(FlSpot(x, y));
    }
    chooseChartData();
  }

  void chooseChartData() {
    List<FlSpot> spots = [];
    for(int i=0;i<curDateIndexs.length;i++) {      
      spots.add(flSpots[curDateIndexs[i]]);
    }
    lineChartBarData.value = LineChartBarData(
      isCurved: true,
      color: AppColors.buttonBackground,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      shadow: Shadow(color: AppColors.fontSecondary.withAlpha(10), offset: Offset(0.w, 15.w)),
      spots: spots,
    );
  }

  String getDividendIncome() {
    double t =
        double.parse(appService.mineInfoModel.value?.withdrawTotal ?? "0.00");
    double b =
        double.parse(appService.mineInfoModel.value?.invitTotal ?? "0.00");
    return (t - b).toStringAsFixed(2);
  }

  Future<void> getOrderList(int curPage) async {    
    AppToast.showLoading();
    NetBaseEntity<OrderListModel> data =
        await appService.httpClient.getOrderList(curPage);
    AppToast.dismiss();
    if (data.code == 200) {
      if(orderList.value!=null) {
        orderList.value?.data.addAll(data.data?.data??[]);
        orderList.value?.lastPage = data.data?.lastPage??0;
      } else {
        orderList.value = data.data;
      }
    } else {
      print(data.message);
    }
  }

  Future<void> getOrderLogList(int curPage) async {
    AppToast.showLoading();
    NetBaseEntity<OrderLogListModel> data = await appService.httpClient.getOrderLogList(0, curPage);
    AppToast.dismiss();
    if (data.code == 200) {
      if(orderLogList0.value!=null) {
        orderLogList0.value?.data.addAll(data.data?.data??[]);
        orderLogList0.value?.lastPage = data.data?.lastPage??0;
      } else {
        orderLogList0.value = data.data;
      }
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

  Future<void> getChartDataList(int days) async {
    int type = earningIndex.value;
    if(earningIndex.value==1) {
      type = 2;
    }else if(earningIndex.value==2) {
      type = 1;
    }
    AppToast.showLoading();
    NetBaseListEntity<ChartDataModel> data =
        await appService.httpClient.getChartData(type, days);
    AppToast.dismiss();
    if (data.code == 200) {
      chartDataList.value = (data.data??[]).reversed.toList();
      getChartData();
    } else {
      print(data.message);
    }
  }

  String getOrderTotal(OrderModel order) {
    if(order.fast==-1 || order.fast == 2) {
      return '0';
    } else {
      return double.parse((1.5 * double.parse(order.orderAmount)).toStringAsFixed(4)).toString();
    }
  }

  String getOutAmount(OrderModel order) {
    double a = double.parse(order.outAmount);
    if(a>0) {
      return double.parse(a.toStringAsFixed(4)).toString();
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
