import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class DailyItemButtonWidget extends StatefulWidget {
  const DailyItemButtonWidget(
      {super.key, required this.icon, required this.label, required this.onPressed});
  final String icon;
  final String label;
  final VoidCallback onPressed;

  @override
  _DailyItemButtonState createState() => _DailyItemButtonState();
}

class _DailyItemButtonState extends State<DailyItemButtonWidget> with TickerProviderStateMixin  {

  late AnimationController _pointController ;
  AppService appService = Get.find<AppService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pointController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this)
        ..forward()..addListener((){
          if(_pointController.isCompleted) {
            _pointController.repeat();
          }
        });
  }

  @override
  void dispose() {
    _pointController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.only(bottom: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.w),
          color: AppColors.secondary
        ),      
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: AppImage.asset(widget.icon), 
                  )
                ),
                Text(appService.getTrans(widget.label), style: TextStyle(color: AppColors.fontPrimary, 
                      fontWeight: FontWeight.bold, fontSize: 14.sp, height: 0.8), textAlign: TextAlign.center,),
                SizedBox(height: 10.h),
                Text("18:31", style: TextStyle(color: AppColors.fontSecondary, fontSize: 13.sp))
              ],
            ),
            Positioned(
              top: -2.h, right: 10.w,
              child: Container(
                width: 8.w, height: 8.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                  color: Colors.white
                ),
              ),
            ).animate(              
              autoPlay: true,
              controller: _pointController,
            )
            .moveY(delay: const Duration(milliseconds: 200), begin: -2.h, end: 3.h, duration: const Duration(milliseconds: 500))
            .fadeIn(delay: const Duration(milliseconds: 200), duration: const Duration(milliseconds: 500))
            .moveY(delay: const Duration(milliseconds: 700),end: -2.h, begin: 3.h, duration: const Duration(milliseconds: 500))
            .fadeOut(delay: const Duration(milliseconds: 700), duration: const Duration(milliseconds: 500))
          ],
        )
      )
    );
  }
}