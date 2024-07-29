import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_constant.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/model/language_model.dart';
import 'package:kombat_flutter/theme/app_colors.dart';

class SelectLanguageView extends StatefulWidget {
  const SelectLanguageView({super.key});

  @override
  _SelectLanguageViewState createState() => _SelectLanguageViewState();
}

class _SelectLanguageViewState extends State<SelectLanguageView> {
  MainController mainController = Get.find();
  RxBool _isHapicFeedback = true.obs;
  RxBool _isCoinsAnim = true.obs;

    @override
  Widget build(BuildContext context) {
    return Obx(()=>Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
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
        Text("Select Language", style: TextStyle(color: AppColors.fontPrimary,
              fontSize: 32.sp, fontWeight: FontWeight.bold)
        ),
        SizedBox(height: 20.h,),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [...List.generate(AppConstant.langs.length, (index) {
                LanguageModel item = AppConstant.langs[index];
                return _getLangItem(item);
              })],
            )
          )
        )
      ]
    ));
  }
  
  Widget _getLangItem(LanguageModel item) {
    return Container(
      constraints: BoxConstraints(minHeight: 70.h),
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
      margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w,),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: GestureDetector(
        onTap: ()=>mainController.lang.value=item.code!,
        child: Row(
          children: [                            
            Expanded(
              child: Text("${item.label} (${item.code})", style: TextStyle(color: AppColors.fontPrimary,
                fontSize: 18.sp, fontWeight: FontWeight.bold)
              )
            ),
            if(item.code==mainController.lang.value)
            const Icon(Icons.check_rounded, color: AppColors.fontSecondary),
            if(item.code!=mainController.lang.value)
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.fontSecondary),
          ],
        )
      )
    );
  }
}