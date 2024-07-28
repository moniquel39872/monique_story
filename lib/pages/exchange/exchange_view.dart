import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_icons.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/app_positioned_background.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppPositionedBackground(assetPath: 'gradient1.png', top: -80, left: 0, height: 400),
          AppPositionedBackground(assetPath: 'back1.png', top: 90, left: 0, height: Get.height+300),          
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.w)),
                            // border: Border.all(color: Colors.transparent, width: 2),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFfa3a01), Color(0xFFffac45),],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10.w)),
                                  color: AppColors.avatarBackground,
                                  border: const Border(right: BorderSide(color: Colors.black, width: 2))
                                ),
                                child: AppImage.asset('avatar5.png')
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Buy\nskin", style: TextStyle(color: AppColors.fontPrimary, fontSize: 11.sp)),
                                    AppImage.asset('avatar5.png')
                                  ]
                                ),
                              )
                            ],
                          ) 
                        ),
                        SizedBox(width: 5.w),
                        Text("Dirk Ackerman(CEO)", style: TextStyle(color: AppColors.fontPrimary, 
                          fontWeight: FontWeight.bold, fontSize: 16.sp)
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.w),
                        color: AppColors.secondary
                      ),
                      child: Row(
                        children: [
                          Icon(AppIcons.key, color: AppColors.iconColor, size: 20.w,),
                          SizedBox(width: 3.w),
                          Text("100", style:TextStyle(color: AppColors.fontPrimary, fontSize: 12.sp)),
                          SizedBox(width: 3.w),
                          Icon(AppIcons.chevron_right, color: AppColors.fontSecondary, size: 10.w,),
                        ],
                      )
                    )
                  ]
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    SizedBox(                      
                      width: 170.w,
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('Bronze', style: TextStyle(color: AppColors.fontPrimary, 
                                      fontWeight: FontWeight.bold, fontSize: 12.sp)
                                    ),
                                    Icon(AppIcons.chevron_right, color: AppColors.fontSecondary, size: 10.w)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("1", style: TextStyle(color: AppColors.fontPrimary, fontWeight: FontWeight.bold, fontSize: 12.sp)),
                                    Text("/11", style: TextStyle(color: AppColors.fontSecondary, fontSize: 12.sp))
                                  ],
                                )
                              ]
                            ),
                          ), 
                          SizedBox(height: 5.h,),
                          Container(                            
                            height: 10.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.h),
                              color: const Color(0xFF49412d),
                              border: Border.all(color: AppColors.borderColor, width: 1.w),                              
                            ),
                          )
                        ],
                      )
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: Container(
                        height: 50.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.w),
                          border: Border.all(color: AppColors.borderColor, width: 2.w),
                          color: const Color(0xFF49412d)
                        ),
                        child: Row(                          
                          children: [
                            AppImage.asset('avatar0.png'),
                            SizedBox(width: 5.w),
                            VerticalDivider(color: AppColors.borderColor, thickness: 2.w, indent: 8.h, endIndent: 8.h,),
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Profit per hour", style: TextStyle(color: AppColors.fontMenu4, fontSize: 13.sp)),
                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppImage.asset('coin.png', width: 25.w),
                                    SizedBox(width: 5.w),
                                    Text("0", style: TextStyle(color: AppColors.fontPrimary, fontWeight: FontWeight.bold, fontSize: 16.sp)),
                                    SizedBox(width: 5.w),
                                    Icon(AppIcons.exclamation_circle, color: AppColors.borderColor, size: 18.w)
                                  ]
                                )
                              ],
                            )),
                            VerticalDivider(color: AppColors.borderColor, thickness: 2.w, indent: 8.h, endIndent: 8.h,),
                            SizedBox(width: 5.w),
                            Icon(Icons.settings, color: AppColors.fontPrimary, size: 30.w)
                          ] 

                        )
                      )
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                      GridView.count(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount:4,
                        mainAxisSpacing: 10.w,
                        crossAxisSpacing: 10.w,
                        children: [
                          _getDailyItem('daily1.png', "Daily reward"),
                          _getDailyItem('daily2.png', "Daily clipher"),
                          _getDailyItem('daily3.png', "Daily combo"),
                          _getDailyItem('daily4.png', "Mini Game"),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppImage.asset('coin.png'),
                          SizedBox(width: 10.w),
                          Countup(
                            begin: 1236,
                            end: 1256,
                            duration: const Duration(seconds: 1),
                            separator: ',',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight : FontWeight.bold,
                              color: Colors.white
                            ), 
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: AppImage.asset("frame1.png", width: 380.w)
                      )
                    ],
                  )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        AppImage.asset("vector1.png"),
                        SizedBox(width: 10.w),
                        Text("1000 / 1000", style: TextStyle(color: AppColors.fontPrimary, 
                          fontWeight: FontWeight.bold, fontSize: 20.sp))
                      ],),
                      Row(children: [
                        AppImage.asset("boost.png"),
                        SizedBox(width: 10.w),
                        Text("Boost", style: TextStyle(color: AppColors.fontPrimary, 
                          fontWeight: FontWeight.bold, fontSize: 20.sp))
                      ],)
                    ],
                  )
                ),
              ],
            )
          ) 
        ],
      )
    );
  }

  Widget _getDailyItem(String icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.w),
        color: AppColors.secondary
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: AppImage.asset(icon), 
            )
          ),
          Text(label, style: TextStyle(color: AppColors.fontPrimary, 
                fontWeight: FontWeight.bold, fontSize: 15.sp)),
          SizedBox(height: 10.h),
          Text("18:31", style: TextStyle(color: AppColors.fontSecondary, fontSize: 13.sp))
        ],
      )
    );
  }
}