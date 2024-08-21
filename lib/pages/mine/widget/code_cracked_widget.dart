// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_icons.dart';
import 'package:kombat_flutter/utils/app_image.dart';

// ignore: must_be_immutable
class CodeCrackedWidget extends StatelessWidget {
  CodeCrackedWidget({super.key, required this.onPressed});
  VoidCallback onPressed;

  AppService appService = Get.find<AppService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width, height: Get.height,
      color: Colors.black.withOpacity(0.9),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(opacity: 0.6, child: AppImage.asset("mine/sunny.png", fit: BoxFit.cover))
            .animate(autoPlay: true)
            .rotate(duration: const Duration(seconds: 5), begin: 0, end: 5.0/8.0),
          AppImage.asset("mine/avatar.png", width: 180.w),
          Positioned(
            bottom: 200.h,
            child: Text(appService.getTrans("The code is cracked.\nYou are a real detective!"),
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700, height: 1),
              textAlign: TextAlign.center,
            )
          ),
          Positioned(
            bottom: 100.h,
            child: Container(
              width: Get.width, height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child:ElevatedButton.icon(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),  
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.fontPrimary, 
                  minimumSize: Size.fromHeight(60.h),
                ),      
                icon: Icon(AppIcons.heart, size: 20.w),
                iconAlignment: IconAlignment.end,
                label:Text(appService.getTrans("Take the prize"),
                  style: TextStyle(fontSize: 20.sp),
                  textAlign: TextAlign.center,
                )
              )
            ),
            
            // child: ElevatedButton(
            //   onPressed: (){                                
            //   }, 
            //   style:  ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),                    
            //     backgroundColor: AppColors.buttonBackground,
            //     foregroundColor: AppColors.fontPrimary,
            //     textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
            //     minimumSize: Size.fromHeight(40.h),
            //   ),
            //   child: Text(appService.getTrans("Take the prize"),
            //     textAlign: TextAlign.center,
            //   )
            // ),
          )
        ],
      )
    );
  }
}