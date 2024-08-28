import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/model/main_tab.dart';
import 'package:kombat_flutter/pages/lottery/lottery_view.dart';
import 'package:kombat_flutter/pages/mine/mine_view.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/app_common_dialog.dart';

import '../app/app_constant.dart';

class MainHome extends GetView<MainController> {
  AppService appService = Get.find<AppService>();
  final GlobalKey<LotteryViewState> lotteryViewKey = GlobalKey();
  final GlobalKey<MineViewState> mineViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => controller.getCurrentPage(lotteryViewKey, mineViewKey)),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,// symmetric(vertical: 7.h, horizontal: 10.w),
        height: 80.h,
        color: AppColors.secondary,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.primary, width: 2.h))
          ),
          child: getBottomTab(),
        ),
      ),
    );
  }

  Widget getBottomTab() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List.generate(AppConstant.mainTabs.length, (index) {
            MainTabModel item = AppConstant.mainTabs[index];
            return InkWell(
              onTap: () {
                if(!appService.isLogin.value) {
                  lotteryViewKey.currentState!.openWalletBottomSheet();
                } else {
                  if(mineViewKey.currentState!=null) {
                    mineViewKey.currentState!.checkIncreasedGolds();
                  }
                  if(item.code=='earn'){
                    appService.initEarnTabIndex = 0;
                  }
                  controller.selectedPath.value = item.navPath;
                }
              },
              borderRadius: BorderRadius.circular(15.w),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5.h),
                width: Get.width /AppConstant.mainTabs.length  - 20.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.w),
                  color: controller.selectedPath.value == item.navPath
                      ? AppColors.primary
                      : AppColors.secondary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: item.code=='exchange'? 
                        AppImage.svgByAsset('${item.icon}.svg',                           
                          width: 40.w
                        ):
                        AppImage.svgByAsset('${item.icon}.svg', 
                          color: controller.selectedPath.value == item.navPath?
                          AppColors.fontPrimary: AppColors.fontSecondary, 
                          width: 40.w
                        ),
                      ),
                    ),
                    Text(appService.getTrans(item.label ?? ""),
                      style: TextStyle(
                        color: controller.selectedPath.value == item.navPath
                            ? AppColors.fontPrimary
                            : AppColors.fontSecondary,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
