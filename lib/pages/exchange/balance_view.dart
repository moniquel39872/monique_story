import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class BalanceView extends StatefulWidget {
  const BalanceView({super.key});

  @override
  _BalanceViewState createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  MainController mainController = Get.find();

    @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 80.h,),
        Padding(padding: EdgeInsets.only(left: 10.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: ()=>mainController.selectedPath.value=exchangePath,
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.fontSecondary)
            ),
          ),
        ),  
        Text("Your balance", style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp)),
        SizedBox(height: 20.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage.asset('coin.png'),
            SizedBox(width: 10.w),
            Text(mainController.scores.toString(), style: TextStyle(color: AppColors.fontPrimary,
              fontSize: 25.sp, fontWeight: FontWeight.bold)
            )
          ],
        ),
        SizedBox(height: 20.h),
        Text("How a boost works", style: TextStyle(color: AppColors.fontMenu1, fontSize: 20.sp)),
        SizedBox(height: 30.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,                
                children: [
                  Align(
                    alignment: Alignment.centerLeft,                    
                    child: Text("Free daily boosters",  style: TextStyle(color: AppColors.fontPrimary,
                      fontSize: 20.sp, fontWeight: FontWeight.bold)
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                    margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 0.w,),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Row(
                      children: [
                        AppImage.asset('vector1.png', width: 50.w, height: 50.w),
                        SizedBox(width: 20.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Full energy", style: TextStyle(color: AppColors.fontPrimary,
                              fontSize: 18.sp, fontWeight: FontWeight.bold)
                            ),
                            Text("6/6 available", style: TextStyle(color: AppColors.fontSecondary,
                              fontSize: 16.sp)
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                      margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 0.w,),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(20.w),                      
                      ),
                      child: Row(
                        children: [
                          AppImage.asset('boost.png', width: 50.w, height: 50.w),
                          SizedBox(width: 20.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Turbo", style: TextStyle(color: AppColors.fontPrimary,
                                fontSize: 18.sp, fontWeight: FontWeight.bold)
                              ),
                              Text("coming soon", style: TextStyle(color: AppColors.fontSecondary,
                                fontSize: 16.sp)
                              ),
                            ],
                          )
                        ],
                      )
                    ) 
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Boosters",  style: TextStyle(color: AppColors.fontPrimary,
                      fontSize: 20.sp, fontWeight: FontWeight.bold)
                    ),                    
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                    margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 0.w,),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Row(
                      children: [
                        AppImage.asset('hand.png', width: 50.w, height: 50.w),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Multitap", style: TextStyle(color: AppColors.fontPrimary,
                                fontSize: 18.sp, fontWeight: FontWeight.bold)
                              ),
                              Row(
                                children: [
                                  AppImage.asset("coin_grey.png", width: 20.w), 
                                  SizedBox(width: 5.w),
                                  Text("2K • 2lvl", style: TextStyle(color: AppColors.fontSecondary,
                                    fontSize: 16.sp)
                                  ),
                                ],
                              )
                            ],
                          )
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.fontSecondary),
                      ],
                    )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                    margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 0.w,),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Row(
                      children: [
                        AppImage.asset('battery.png', width: 50.w, height: 50.w),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Energy limit", style: TextStyle(color: AppColors.fontPrimary,
                                fontSize: 18.sp, fontWeight: FontWeight.bold)
                              ),
                              Row(
                                children: [
                                  AppImage.asset("coin_grey.png", width: 20.w), 
                                  SizedBox(width: 5.w),
                                  Text("2K • 2lvl", style: TextStyle(color: AppColors.fontSecondary,
                                    fontSize: 16.sp)
                                  ),
                                ],
                              )                              
                            ],
                          )
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.fontSecondary),
                      ],
                    )
                  ),
                ],
              ),
            )
          )
        )
        
      ],
    );
  }
}