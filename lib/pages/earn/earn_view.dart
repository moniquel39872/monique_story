import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_constant.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/model/earn_item_model.dart';
import 'package:kombat_flutter/model/order_log_model.dart';
import 'package:kombat_flutter/model/order_model.dart';
import 'package:kombat_flutter/pages/earn/earn_controller.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_date_util.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class EarnView extends StatefulWidget {
  const EarnView({super.key});

  @override
  State<EarnView>  createState() => _EarnViewState();
}

class _EarnViewState extends State<EarnView>  with TickerProviderStateMixin {
  final AppService appService = Get.find<AppService>();
  EarnController controller = Get.put(EarnController());
  bool _isFirstLoad = true;
  late List<Tab> tabs;
  late TabController _tabController;  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = <Tab> [Tab(text: appService.getTrans('My Orders')), Tab(text: appService.getTrans('My Earnings'))];     
    _isFirstLoad = appService.firstLoad['earn']??true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appService.firstLoad['earn']=false;
    });

    _tabController = TabController(length: tabs.length, vsync: this, initialIndex: appService.initEarnTabIndex);

    controller.getOrderList();
    controller.getOrderLogList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Gap(30.h),
          TabBar(              
            controller: _tabController,
            isScrollable: true,
            physics: const ClampingScrollPhysics(),
            indicatorSize: TabBarIndicatorSize.label,
            tabAlignment: TabAlignment.start,
            labelStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700), 
            indicator: null,
            labelColor: AppColors.fontPrimary,
            indicatorColor: AppColors.buttonBackground,
            tabs: tabs,            
          ),
          Obx(()=>Expanded(
            child: TabBarView(controller: _tabController, physics: const NeverScrollableScrollPhysics(),
              children: [
                controller.isLoading1.value?
                Container():
                ListView.builder(
                  itemCount: (controller.orderList.value?.data??[]).length,
                  itemBuilder: (BuildContext context, int index){
                    OrderModel item = controller.orderList.value!.data[index];
                    return _getOrderItem(item);
                    // return Container();
                  },
                ), 
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _getEarnSummaryItem(0, double.parse(appService.mineInfoModel.value?.withdrawTotal??"0.00").toStringAsFixed(2), 
                            'earn/total_revenue.png', 'Total Revenue', controller.earningIndex.value==0),
                          _getEarnSummaryItem(1, controller.getDividendIncome(), 
                            'earn/money_growth.png', 'Dividend income', controller.earningIndex.value==1),
                          _getEarnSummaryItem(2, double.parse(appService.mineInfoModel.value?.invitTotal??"0.00").toStringAsFixed(2), 
                            'earn/financial_loss.png', 'Burn gains', controller.earningIndex.value==2),
                        ],
                      ),
                      SizedBox(height: 250.h,),
                      Expanded(
                        child: controller.isLoading2.value?
                        Container():
                        ListView.builder(
                          itemCount: controller.orderLogs.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _getOrderLogItem(controller.orderLogs.value[index]);
                          }
                        )
                      )
                    ]
                  )
                )
              ]
            )
          ))
        ]
      )
    );
  }

  Widget _getOrderItem(OrderModel item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        color: AppColors.cardBackground
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${appService.getTrans('No ')} ${item.orderNo}', 
                style: TextStyle(color: AppColors.fontPrimary, fontSize: 20.sp, fontWeight: FontWeight.w700)
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: item.fast==-1? AppColors.buttonBackground:AppColors.level,
                  borderRadius: BorderRadius.circular(10.w)
                ),
                child: Text(appService.getTrans(item.fast==-1?'Not Awarded':'Awarded'), style: TextStyle(color: AppColors.fontPrimary, fontSize: 15.sp))
              )
            ]
          ),          
          if(double.parse(item.orderAmount)!=0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppImage.asset('earn/coins1.png', width: 40.w),
                  Gap(10.w),
                  Text(appService.getTrans('Earnings'),
                    style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)
                  ),
                  Gap(20.w),
                  item.status==0?
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.fontSecondary, width: 1.w),
                      borderRadius: BorderRadius.circular(20.w)
                    ),
                    child: Text(appService.getTrans("Unsettled"), style: TextStyle(color: AppColors.fontSecondary, fontSize: 15.sp))
                  )
                  : double.parse(item.orderAmount)>0?
                  Text('+${double.parse(item.orderAmount).toPrecision(4)} USDT', style: TextStyle(color: AppColors.fontMenu3, fontSize: 15.sp))
                  :Text('${item.orderAmount} USDT', style: TextStyle(color: AppColors.font3, fontSize: 15.sp))
                ],
              ),
              double.parse(item.outAmount)!=0?
              Container()
              :
              Text(item.updateAt!=null? AppDateUtil.YMdhms(item.updateAt??0) : AppDateUtil.YMdhms(item.createdAt), style: TextStyle(color: AppColors.fontSecondary, fontSize: 15.sp),
                textAlign: TextAlign.right,
              )
            ],
          ),
          
          if(double.parse(item.outAmount)!=0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppImage.asset('earn/coins2.png', width: 40.w),
                  Gap(10.w),
                  Text(appService.getTrans('Blessing Earnings'),
                    style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)
                  ),
                  Gap(20.w),
                  item.status==0?
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.fontSecondary, width: 1.w),
                      borderRadius: BorderRadius.circular(20.w)
                    ),  
                    child: Text(appService.getTrans("Unsettled"), style: TextStyle(color: AppColors.fontSecondary, fontSize: 15.sp))
                  )
                  : double.parse(item.outAmount)>0?
                  Text('+${double.parse(item.outAmount).toPrecision(4)} USDT', style: TextStyle(color: AppColors.fontMenu3, fontSize: 15.sp))
                  :Text('${item.orderAmount} USDT', style: TextStyle(color: AppColors.font3, fontSize: 15.sp))
                ],
              ),              
              Text(item.updateAt!=null? AppDateUtil.YMdhms(item.updateAt??0) : AppDateUtil.YMdhms(item.createdAt), style: TextStyle(color: AppColors.fontSecondary, fontSize: 15.sp),
                textAlign: TextAlign.right,
              )
            ],
          )
        ],
      )
    );
  }

  Widget _getEarnSummaryItem(int index, String prize, String icon, String label, bool isSelected) {
    return Expanded(
      flex: 1,
      child: Opacity(
        opacity: isSelected?1:0.3,
        child: GestureDetector(
          onTap: (){
            controller.earningIndex.value=index;
            controller.chooseOrderLogs();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              color: AppColors.cardBackground
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('$prize USDT', 
                  style: TextStyle(color: AppColors.fontPrimary, fontSize: 20.sp)
                ),
                AppImage.asset(icon, height: 100.h),
                Text(appService.getTrans(label),
                  style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)
                )
              ]
            )
          )
        )
      )
    );
  }

  Widget _getOrderLogItem(OrderLogModel item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        color: AppColors.cardBackground
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(            
            children: [
              (item.type)>1 ? AppImage.asset('earn/dividend.png', width: 50.w) : AppImage.asset('earn/burn_gains.png', width: 50.w),
              Gap(10.w),
              Text(appService.getTrans((item.type)>1 ? "Dividend" : "Burn"), style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp))
            ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('+${item.outAmount} USDT', style: TextStyle(color: AppColors.fontMenu3, fontSize: 18.sp)),
              Gap(5.h),
              Text(AppDateUtil.YMdhms(item.createdAt), style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp))
            ]
          )
        ],
      )
    );
  }
}
