import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gap/gap.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_icons.dart';

class AppToast {   
  static Widget  _getWidget({String? msg, Widget? prefixWidget, bool? isClose}){
    return SizedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 30.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          color: AppColors.secondary
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              if(prefixWidget!=null)
              prefixWidget,
              Gap(10.w),
              Text(msg??"", style:TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)),
            ],),
            if(isClose==true)
            GestureDetector(
              onTap:()=>AppService.toastResult.call(),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              )
            ),
            if(isClose==null||isClose==false)
            SizedBox(height: 10.h)
          ]
        )
      )
    );
  }

  static SlideTransition _getTransition(AnimationController controller, Widget widget) {
    return SlideTransition(
      position: getAnimation<Offset>(
      const Offset(0.0, -0.05), 
      const Offset(0.0, 0.05), 
      controller,
      curve: Curves.easeInOut),
      child: widget,
    );
  }

  static Future showToast(String msg) async {    
    //return await EasyLoading.showToast(msg ?? "");    
    dismiss();
    AppService.toastResult = BotToast.showAnimationWidget(                    
      onlyOne: true,
      allowClick: false,   
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      wrapAnimation: (controller, cancelFunc, widget) {
        return _getTransition(controller, widget);
      },
      toastBuilder:(_){
        return _getWidget(msg: msg, isClose: true);
      },
    );
  }

  static Future showLoading({String? msg}) async {
    // return await EasyLoading.show(status: msg ?? "加载中");
    dismiss();
    AppService.toastResult = BotToast.showAnimationWidget(                    
      onlyOne: true,
      allowClick: false,         
      animationDuration: const Duration(milliseconds: 500),
      wrapAnimation: (controller, cancelFunc, widget) {
        return _getTransition(controller, widget);
      },
      toastBuilder:(_){
        return _getWidget(msg: msg??"加载中", 
          prefixWidget: SizedBox(
            height: 30.w,
            width: 30.w,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.fontPrimary)
            ),
          ),
          isClose: false)
        ;
      },
    );
  }

  static Future dismiss() async {
    AppService.toastResult.call();
    // return await EasyLoading.dismiss();
  }

  static Future showSuccess({String? msg}) async {
    // return await EasyLoading.showSuccess(msg ?? "操作成功");
    dismiss();
    AppService.toastResult = BotToast.showAnimationWidget(                    
      onlyOne: true,
      allowClick: false,         
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      wrapAnimation: (controller, cancelFunc, widget) {
        return _getTransition(controller, widget);
      },
      toastBuilder:(_){
        return _getWidget(msg: msg??"操作成功", 
          prefixWidget: Icon(Icons.check_circle, color: AppColors.fontMenu3, size: 30.w,),
          isClose: false
        );
      },
    );
  }

  static Future showError({String? msg}) async {
    // return await EasyLoading.showError(msg ?? "操作失败");
    dismiss();
    AppService.toastResult = BotToast.showAnimationWidget(                    
      onlyOne: true,
      allowClick: false,         
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      wrapAnimation: (controller, cancelFunc, widget) {
        return _getTransition(controller, widget);
      },
      toastBuilder:(_){
        return _getWidget(msg: msg??"操作失败", 
          prefixWidget: Icon(AppIcons.exclamation_circle , color: AppColors.font3, size: 30.w,),
          isClose: false
        );
      },
    );
  }

  // static Future showDuration({String? msg, int? duration}) async {
  //   EasyLoading.show(status: msg ?? "加载中");
  //   await Future.delayed(Duration(seconds: duration ?? 3));
  //   EasyLoading.dismiss();
  // }
}
