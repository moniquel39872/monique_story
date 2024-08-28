import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kombat_flutter/theme/app_colors.dart';

class AppCommonDialog extends StatefulWidget  {
  const AppCommonDialog({
    super.key,
    this.okLabel,
    this.onOk,
    this.onCancel,
    this.msg,
    this.cancelLabel,
    this.title,
  });
  
  final VoidCallback? onOk;
  final VoidCallback? onCancel;
  final String? msg;
  final String? title;
  final String? okLabel;
  final String? cancelLabel;

  @override
  State<AppCommonDialog> createState() => AppCommonDialogState();
}

class AppCommonDialogState extends State<AppCommonDialog> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: AlertDialog(
            title: widget.title!=null?Text(widget.title??''):null,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
            content: Text(widget.msg??'', textAlign: TextAlign.center,),
            alignment: Alignment.center,
            contentTextStyle: TextStyle(color: AppColors.fontPrimary, fontSize: 20.sp),
            // contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            backgroundColor: AppColors.secondary,
            scrollable: true,
            actions: <Widget>[
              ElevatedButton(                    
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.fontSecondary,
                  foregroundColor: AppColors.fontPrimary,
                  padding: EdgeInsets.zero,
                  minimumSize: Size(150.w, 50.h)
                ),
                onPressed: (){            
                  // Navigator.pop(context);
                  widget.onCancel?.call();
                },
                child: Text(widget.cancelLabel??'Cancel', style: TextStyle(fontSize: 18.sp),),
              ),
              ElevatedButton(                    
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.fontPrimary,
                  padding: EdgeInsets.zero,
                  minimumSize: Size(150.w, 50.h)
                ),
                onPressed: (){
                  // Navigator.pop(context);
                  widget.onOk?.call();            
                },
                child: Text(widget.okLabel??'OK', style: TextStyle(fontSize: 18.sp),),
              )
            ],
            actionsAlignment: MainAxisAlignment.spaceAround,
          )
        )
      )
    );
  }
}