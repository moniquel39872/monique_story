import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    SizedBox(height: 20.h,),
                    Text("Skin",  style: TextStyle(color: AppColors.fontPrimary,
                      fontSize: 18.sp, fontWeight: FontWeight.bold)
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.arrow_back_ios_new_rounded)
                        ),
                        Expanded(child: AppImage.asset('skin/default.png')),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.arrow_forward_ios_rounded)
                        ),
                      ],
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
    );
  }
}