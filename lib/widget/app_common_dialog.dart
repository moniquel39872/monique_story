import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kombat_flutter/theme/app_colors.dart';

class AppCommonDialog extends StatelessWidget {
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
  Widget build(BuildContext context) {

    return AlertDialog(
      title: title!=null?Text(title??''):null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
      content: Text(msg??'', textAlign: TextAlign.center,),
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
            onCancel?.call();
          },
          child: Text(cancelLabel??'Cancel', style: TextStyle(fontSize: 18.sp),),
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
            onOk?.call();            
          },
          child: Text(okLabel??'OK', style: TextStyle(fontSize: 18.sp),),
        )
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    );
  }
}