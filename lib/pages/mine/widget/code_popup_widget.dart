import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'dart:math' as math;

import 'package:kombat_flutter/theme/app_colors.dart';

// ignore: must_be_immutable
class CodePopupWidget extends StatelessWidget {
  CodePopupWidget({super.key});

  AppService appService = Get.find<AppService>();

  void _logoutPressed(BuildContext context) {
    Navigator.of(context).pop('Logout pressed');
  }  

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    ScrollController scrollController = ScrollController();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
      width: 330.w, height: 240.h,            
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appService.getTrans("Play games, get codes and earn keys"), style: TextStyle(fontSize: 14.sp, color: AppColors.fontPrimary)),
          Gap(10.h),
          Text(appService.getTrans("Enter the code"), style: TextStyle(fontSize: 14.sp, 
            color: AppColors.fontPrimary, fontWeight: FontWeight.w700), 
          ),
          Container(
            height: 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: AppColors.secondary,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    scrollController: scrollController,
                    style: TextStyle(color: AppColors.fontPrimary, fontSize: 17.sp) ,
                    maxLines: 1,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(left: 10.w, right: 10.w),
                      border: InputBorder.none,                      
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){}, 
                  style:  ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),                    
                    backgroundColor: AppColors.buttonBackground,
                    foregroundColor: AppColors.fontPrimary,
                    textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700)
                  ),
                  child: Text(appService.getTrans("Redeem"))
                )
              ],
            )
          ),
          SizedBox(height: 15.h,),
          Container(height: 2.h, color: AppColors.secondary),
          SizedBox(height: 15.h,),
          Container(
            height: 50.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFff5f3c), Color(0xFFffb145)]),
              borderRadius: BorderRadius.circular(10.w)
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
                backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
                foregroundColor: AppColors.fontPrimary,
                textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
                minimumSize: Size.fromHeight(40.h),
              ),
              child: Text(appService.getTrans('Go to games'), textAlign: TextAlign.center,),
            ),
          ),
          // ElevatedButton(
          //   onPressed: (){}, 
          //   style:  ElevatedButton.styleFrom(
          //     padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),                    
          //     backgroundColor: AppColors.buttonBackground,
          //     foregroundColor: AppColors.fontPrimary,
          //     textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
          //     minimumSize: const Size.fromHeight(40),
          //   ),
          //   child: const Text("Go to games")
          // )
        ],
      )
    );
  }
}