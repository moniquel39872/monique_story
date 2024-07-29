import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/app_bottomsheet_widget.dart';

class LotteryView extends StatefulWidget {
  const LotteryView({super.key});

  @override
  _LotteryViewState createState() => _LotteryViewState();
}

class _LotteryViewState extends State<LotteryView> {

  RxBool _isOpenApp = false.obs;
  RxBool _isJoining = false.obs;
  double _currentValue = 100;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Column(
      children: [        
        Expanded(
          child: AppImage.asset('lottery.png', fit: BoxFit.cover)
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(!_isOpenApp.value)
              ElevatedButton(
                onPressed: openBottomSheet, 
                style:  ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),                    
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.fontPrimary,
                  textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  fixedSize: Size(250.w, 50.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImage.asset('coin.png', width: 30.w),
                    SizedBox(width: 10.w),
                    const Text("Connect with wallet")
                  ],
                ),
              ),
              if(_isOpenApp.value && !_isJoining.value)
              ElevatedButton(
                onPressed: ()=>_isJoining.value=true, 
                style:  ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),                    
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.fontPrimary,
                  textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  fixedSize: Size(250.w, 50.h),
                ),
                child: Text("Join in", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              ),
              if(_isOpenApp.value && _isJoining.value)
              FAProgressBar(
                currentValue: _currentValue,
                displayText: '%',
                progressGradient: LinearGradient(
                  colors: [
                    const Color(0xFF3772fe).withOpacity(0.75),
                    const Color(0xFF6060ff).withOpacity(0.75),
                  ],
                ),
                size: 20.h,
                animatedDuration: const Duration(seconds: 5),
                border: Border.all(color: AppColors.fontSecondary, width: 1),                
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ending in", style:TextStyle(fontSize: 18.sp, color: AppColors.fontSecondary)),
                      Text("8h 41m 20s", style:TextStyle(fontSize: 22.sp, color: AppColors.fontPrimary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Income", style:TextStyle(fontSize: 18.sp, color: AppColors.fontSecondary)),
                          Text("4.10USDT", style:TextStyle(fontSize: 22.sp, color: AppColors.fontPrimary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(width: 20.w),
                      AppImage.asset("coin.png")
                    ]
                  ) 
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      _isOpenApp.value=false;
                      _isJoining.value=false;
                    }, 
                    style:  ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.w),
                        side: BorderSide(color: AppColors.fontSecondary, width: 2.w)
                      ),
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.fontPrimary,
                      textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      minimumSize: Size(200.w, 40.h)
                    ),
                    child: const Text("收益统计")
                  ),
                  ElevatedButton(
                    onPressed: (){
                      _isOpenApp.value=false;
                      _isJoining.value=false;
                    }, 
                    style:  ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),                    
                      backgroundColor: AppColors.buttonBackground,
                      foregroundColor: AppColors.fontPrimary,
                      textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      minimumSize: Size(200.w, 40.h)
                    ),
                    child: const Text("个人订单")
                  ),
                ],
              )
            ],
          ),
        )        
      ]
    ));
  }

  void openBottomSheet() {
    Get.bottomSheet(
      AppBottomsheetWidget(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Column(
            children: [
              AppImage.asset('income.png',),
              SizedBox(height: 30.h),
              Text('Chosse your wallet', style: TextStyle(color: AppColors.fontPrimary,
                  fontSize: 25.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.h,),
              Text('By connecting your wallet, you agree to our Terms of Service and our Privacy policy', 
                style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h,),      
              _getWalletConnectItem("rainbow.png", "Rainbow"),
              _getWalletConnectItem("coinbase.png", "Coinbase"),
              _getWalletConnectItem("metamask.png", "Metamask"),
            ],
          ),
        )                      
      ),
      isScrollControlled: false,
    );
  }

  Widget _getWalletConnectItem(String icon, String label) {
    return GestureDetector(
      onTap: confirmOpenApp,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
        margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 0.w,),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Row(
          children: [
            AppImage.asset(icon, width: 50.w, height: 50.w),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(label, style: TextStyle(color: AppColors.fontPrimary,
                fontSize: 18.sp, fontWeight: FontWeight.bold)
              ), 
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.fontSecondary),
          ],
        )
      )
    );  
  }

  void confirmOpenApp() {
    showDialog( context: context, barrierDismissible: false, builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            color: AppColors.primary,
          ),
          height: 200.h,          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("This page will open another application."),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                  _isOpenApp.value = true;
                }, 
                style:  ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),                    
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.fontPrimary,
                  textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  minimumSize: Size(200.w, 40.h)
                ),
                child: const Text("Open")
              ),
              ElevatedButton(
                onPressed: ()=>Navigator.of(context).pop(), 
                style:  ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.w),
                    side: BorderSide(color: AppColors.fontSecondary, width: 2.w)
                  ),
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.fontPrimary,
                  textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  minimumSize: Size(200.w, 40.h)
                ),
                child: const Text("Cancel")
              ),
            ]
          )
        )
      );
    });
  }
}