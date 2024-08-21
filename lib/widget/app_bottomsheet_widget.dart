import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/theme/app_colors.dart';

class AppBottomsheetWidget extends StatefulWidget {
  AppBottomsheetWidget({
    super.key,
    required this.child,
    this.topImage
  });

  final Widget child;
  Widget? topImage; 

  @override
  State<AppBottomsheetWidget> createState() => _AppBottomsheetWidgetState();
}

class _AppBottomsheetWidgetState extends State<AppBottomsheetWidget> {

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 46.h,
            width: Get.width,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: 46.h,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow,
                        spreadRadius: 8,
                        blurRadius: 40,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                  ),
                ),
                Container(
                  height: 45.h,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38),
                      topRight: Radius.circular(38),
                    ),
                  ),
                ),                        
              ],
            )
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 0.h),
              color: AppColors.primary
            ),          
            padding: EdgeInsets.zero,
            width: double.infinity,
            child: widget.child,
          ),
        ],
      ),      
      Positioned(
        top: 20.h, right: 10.w,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(right: 15.w),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff4E4F50),
            ),
            child: const Icon(
              Icons.close_rounded,
              size: 25,
            ),
          ),
        ),
      ),
      if(widget.topImage!=null) 
      Positioned(
        top:  0.h,
        child: Container(
          alignment: Alignment.center,
          width: Get.width,          
          child: widget.topImage
        )
      ),    
    ]);
  }
}
