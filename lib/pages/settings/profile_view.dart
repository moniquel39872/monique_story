import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_constant.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/model/skin_model.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/utils/app_utils.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  MainController mainController = Get.find();
  RxInt skinIndex = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    skinIndex.value = AppConstant.skins.indexWhere((item)=>item.code==mainController.skin.code);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40.h,),            
            Text("Profile", style: TextStyle(color: AppColors.fontPrimary,
              fontSize: 25.sp, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [                  
                  Container(
                    width: 40.h, height: 40.h,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: AppColors.avatarBackground,
                      border: const Border(right: BorderSide(color: Colors.black, width: 2))
                    ),
                    child: AppImage.asset('avatar5.png'),
                  ),
                  SizedBox(width: 10.w),
                  Text("Dirk Ackerman", style: TextStyle(color: AppColors.fontPrimary,
                    fontSize: 18.sp, fontWeight: FontWeight.bold)
                  ),                  
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(height: 0.5.h, color: AppColors.fontSecondary),
            ),
            SizedBox(height: 20.h,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.w), topRight: Radius.circular(50.w)
                  ),
                  color: AppColors.primary
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,                  
                  children: [
                    SizedBox(height: 15.h,),
                    Text("Skin",  style: TextStyle(color: AppColors.fontPrimary,
                      fontSize: 20.sp, fontWeight: FontWeight.bold)
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (){
                            if(skinIndex>0) {
                              skinIndex.value--;
                            }
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded)
                        ),
                        AppImage.asset('skin/${AppConstant.skins[skinIndex.value].icon}', height: 350.h),
                        IconButton(
                          onPressed: (){
                            if(skinIndex<AppConstant.skins.length-1){
                              skinIndex++;
                            }
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded)
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Expanded(
                      child: Container(
                        width: Get.width,
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w)
                          ),
                          border: Border(bottom: BorderSide(color:AppColors.primary, width: 2.w)),
                          color: AppColors.secondary
                        ),
                        child: loadSkinPurchasePanel(),
                      )
                    )
                  ],
                )
              )
            )
          ]
        ),        
        Positioned(
          top: 40.h, left: 10.w,
          child: GestureDetector(
            onTap: ()=>mainController.selectedPath.value=exchangePath,
            child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.fontSecondary)
          ),
        )
      ],
    ));
  }

  Widget loadSkinPurchasePanel() {
    SkinModel skin = AppConstant.skins[skinIndex.value];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          Text(skin.label??"", style: TextStyle(color: AppColors.fontPrimary,
            fontSize: 20.sp, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 10.h,),
          Text(skin.code==mainController.skin.code?"Your leagues's default skin":skin.desc??"",  
            style: TextStyle(color: AppColors.fontPrimary, fontSize: 15.sp), textAlign: TextAlign.center,
          ),
        ],),
        if(skin.code==mainController.skin.code)
        Text("Purchased",  style: TextStyle(color: AppColors.fontMenu3,
          fontSize: 18.sp)
        ),
        if(skin.code!=mainController.skin.code)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage.asset("coin_grey.png", width:35.w), SizedBox(width: 10.w),
            Text(AppUtils.intToStrWithComma(skin.price??0), style: TextStyle(color: AppColors.fontSecondary,
              fontSize: 25.sp, fontWeight: FontWeight.bold))
          ],
        ),
        ElevatedButton(
          onPressed: (){                                
          }, 
          style:  ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),                    
            backgroundColor: AppColors.buttonBackground,
            foregroundColor: AppColors.fontPrimary,
            textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            minimumSize: Size.fromHeight(70.h),
          ),
          child: Text(skin.code==mainController.skin.code?"Choose":"Reach the ${skin.type} league to unlock the skin")
        ),
      ],
    );
  }
}