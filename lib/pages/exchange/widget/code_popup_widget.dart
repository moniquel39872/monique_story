import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:kombat_flutter/theme/app_colors.dart';

class CodePopupWidget extends StatelessWidget {
  const CodePopupWidget({super.key});

  void _logoutPressed(BuildContext context) {
    Navigator.of(context).pop('Logout pressed');
  }  

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    ScrollController _scrollController = ScrollController();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
      width: 330.w, height: 235.h,            
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Play games, get codes and earn keys", style: TextStyle(fontSize: 14.sp, color: AppColors.fontPrimary)),
          SizedBox(height: 10.h),
          Text("Enter the code", style: TextStyle(fontSize: 14.sp, 
            color: AppColors.fontPrimary, fontWeight: FontWeight.bold), 
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
                    controller: _textEditingController,
                    scrollController: _scrollController,
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
                    textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)
                  ),
                  child: const Text("Redeem")
                )
              ],
            )
          ),
          SizedBox(height: 20.h,),
          Container(height: 2.h, color: AppColors.secondary),
          SizedBox(height: 20.h,),
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
                textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                minimumSize: Size.fromHeight(40.h),
              ),
              child: const Text('Go to games'),
            ),
          ),
          // ElevatedButton(
          //   onPressed: (){}, 
          //   style:  ElevatedButton.styleFrom(
          //     padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),                    
          //     backgroundColor: AppColors.buttonBackground,
          //     foregroundColor: AppColors.fontPrimary,
          //     textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          //     minimumSize: const Size.fromHeight(40),
          //   ),
          //   child: const Text("Go to games")
          // )
        ],
      )
    );
  }
}