import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/theme/app_colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  MainController mainController = Get.find();
  AppService appService = Get.find<AppService>();
  final RxBool _isHapicFeedback = true.obs;
  final RxBool _isCoinsAnim = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 80.h,),
        Padding(padding: EdgeInsets.only(left: 10.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: ()=>mainController.selectedPath.value=minePath,
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.fontSecondary)
            ),
          ),
        ),
        Text(appService.getTrans("Settings"), style: TextStyle(color: AppColors.fontPrimary,
              fontSize: 32.sp, fontWeight: FontWeight.w700)
        ),
        SizedBox(height: 20.h,),
        GestureDetector(
          onTap: ()=>mainController.selectedPath.value=selectLangPath,
          child: Container(
            constraints: BoxConstraints(minHeight: 70.h),
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
            margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w,),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Row(
              children: [                            
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appService.getTrans("Select Language"), style: TextStyle(color: AppColors.fontPrimary,
                        fontSize: 18.sp, fontWeight: FontWeight.w700)
                      ),
                      Text(appService.getLanguageByCode(appService.currentLang.value).name??"", style: TextStyle(color: AppColors.fontSecondary,
                        fontSize: 16.sp)
                      ),
                    ],
                  )
                ),
                const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.fontSecondary),
              ],
            )
          )
        ),
        // Container(
        //   constraints: BoxConstraints(minHeight: 70.h),
        //   padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
        //   margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w,),
        //   decoration: BoxDecoration(
        //     color: AppColors.secondary,
        //     borderRadius: BorderRadius.circular(20.w),
        //   ),
        //   child: Row(
        //     children: [ 
        //       Expanded(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(appService.getTrans("Choose exchange"), style: TextStyle(color: AppColors.fontPrimary,
        //               fontSize: 18.sp, fontWeight: FontWeight.w700)
        //             ),
        //             Text("Gate.io", style: TextStyle(color: AppColors.fontSecondary,
        //               fontSize: 16.sp)
        //             ),
        //           ],
        //         )
        //       ),
        //       const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.fontSecondary),
        //     ],
        //   )
        // ),
        // Container(
        //   constraints: BoxConstraints(minHeight: 70.h),
        //   padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
        //   margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w,),
        //   decoration: BoxDecoration(
        //     color: AppColors.secondary,
        //     borderRadius: BorderRadius.circular(20.w),
        //   ),
        //   child: Row(
        //     children: [ 
        //       Expanded(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(appService.getTrans("Delete account"), style: TextStyle(color: AppColors.fontPrimary,
        //               fontSize: 18.sp, fontWeight: FontWeight.w700)
        //             ),                    
        //           ],
        //         )
        //       ),
        //       const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.fontSecondary),
        //     ],
        //   )
        // ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(appService.getTrans("Haptic Feedback"), style: TextStyle(color: AppColors.fontPrimary,
        //         fontSize: 20.sp, fontWeight: FontWeight.w700)
        //       ),
        //       FlutterSwitch(
        //           width: 50.h, height: 30.h,
        //           value: _isHapicFeedback.value,
        //           activeColor: const Color(0xff11c1f3),
        //           onToggle: (bool value) => _isHapicFeedback.value=value ,
        //         )
        //     ],
        //   )
        // ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(appService.getTrans("Coins animation"), style: TextStyle(color: AppColors.fontPrimary,
        //         fontSize: 20.sp, fontWeight: FontWeight.w700)
        //       ),
        //       FlutterSwitch(
        //           width: 50.h, height: 30.h,
        //           value: _isCoinsAnim.value,
        //           activeColor: const Color(0xff11c1f3),
        //           onToggle: (bool value) => _isCoinsAnim.value=value ,
        //         )
        //     ],
        //   )
        // ),
        SizedBox(height: 30.h,),
        Align(alignment: Alignment.center,
          child: Text(appService.getTrans("Privacy policy"), style: TextStyle(color: AppColors.fontSecondary,
            fontSize: 18.sp)
          )
        )
      ],
    ));
  }
}