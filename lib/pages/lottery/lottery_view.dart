import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/pages/lottery/lottery_controller.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/app_bottomsheet_widget.dart';
import 'package:kombat_flutter/widget/app_toast.dart';
import 'package:lottie/lottie.dart';

class LotteryView extends StatefulWidget {
  const LotteryView({required GlobalKey key}) : super(key: key);

  @override
  State<LotteryView> createState() => LotteryViewState();
}

class LotteryViewState extends State<LotteryView> with TickerProviderStateMixin {

  final AppService appService = Get.find<AppService>();
  final MainController mainController = Get.find();
  final LotteryController controller = Get.put(LotteryController());
  late final AnimationController _animController;

  // final RxBool _isOpenApp = false.obs;
  // final RxBool _isJoining = false.obs;
  // final double _currentValue = 100;
  // bool _isFirstLoad = true;
  Duration duration = const Duration(microseconds: 200);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _isFirstLoad = appService.firstLoad['lottery']??true;
    _animController = AnimationController(vsync: this);
    _animController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _animController.reset();
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: Get.width, height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/playground/background.png'),
            fit: BoxFit.fill
          )
        ),
        child: Column(children: [
          Gap(50.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(children: [
              CircleAvatar(                    
                radius: 30.w,
                backgroundImage: const ExactAssetImage('assets/images/playground/avatar.png'),        
                child: Stack(alignment: Alignment.topRight,
                  children: [
                    Positioned(
                      right: 0,
                      child: AppImage.asset('playground/not_verified.png')
                    )
                  ],
                ),
              ),
              Gap(30.w),
              Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      AppImage.asset('playground/income.png', height: 45.h),
                      Gap(5.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [                        
                          Text(appService.getTrans('Income'), style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp)),
                          Text('4.10 USDT', style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)),
                        ]
                      )
                    ],),
                    Row(children: [
                      AppImage.asset('playground/ending.png', height: 45.h),
                      Gap(5.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(appService.getTrans('Ending in'), style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp)),
                          Text('3h 41m 12s', style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)),
                        ]
                      )
                    ],)
                  ],
                )
              )
            ],)
          ),
          Gap(15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: FAProgressBar(
              currentValue: 70,
              backgroundColor: AppColors.progressBackground,
              border: Border.all(color: AppColors.progressBorder, width: 2.h),
              borderRadius: BorderRadius.circular(10.w),
              progressColor: AppColors.progress,
              size: 20.h
            ),
          ),
          Expanded(
            child: Center(
              child: Lottie.asset(
                'assets/lottie/data.json',
                controller: _animController,
                width: 450.w,
                height: 650.h,
                onLoaded: (composition) {
                  duration = composition.duration;
                },
              ),
              //AppImage.asset('playground/lottery.png')
            )
          ),
          Obx(()=>Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  appService.initEarnTabIndex = 1;
                  mainController.selectedPath.value=earnPath;
                },
                child: Column(
                  children: [
                    Gap(5.h),
                    AppImage.asset('playground/earn.png', width: 70.w),
                    Text(appService.getTrans('Earn'), style:TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp))
                  ],
                )
              ),
              appService.isLogin.value==true 
              ?
              GestureDetector(
                onTap: (){
                  _animController
                  ..duration = duration
                  ..forward();
                  appService.getMineInfo();
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.w),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/playground/frame.png')
                        )
                      ),
                      child: AppImage.asset('playground/main.png', width: 70.w)
                    ),
                    Gap(10.h),
                    Text(appService.getTrans('Twist'), style:TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)),
                    AppImage.asset('playground/arrow_top.png')
                  ],
                ),
              )
              :
              GestureDetector(
                onTap: () {
                  openBottomSheet();
                },//openBottomSheet,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.w),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/playground/frame.png')
                        )
                      ),
                      child: AppImage.asset('playground/connect.png', width: 70.w)
                    ),
                    Gap(10.h),
                    Text(appService.getTrans('Connect Wallet'), style:TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)),
                    AppImage.asset('playground/arrow_top.png')
                  ],
                ),
              ),              
              GestureDetector(
                onTap: (){
                  appService.initEarnTabIndex = 0;
                  mainController.selectedPath.value=earnPath;
                },
                child: Column(
                  children: [
                    Gap(5.h),
                    AppImage.asset('playground/order.png', width: 70.w),
                    Text(appService.getTrans('Order'), style:TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp))
                  ],
                )
              )
            ],
          ))
        ],)
      )
    );
  }

  void openBottomSheet() {
    Get.bottomSheet(
      AppBottomsheetWidget(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Column(
            children: [
              AppImage.asset('playground/wallet.png', width: 150.w),
              Text(appService.getTrans('Chosse your wallet'), style: TextStyle(color: AppColors.fontPrimary,
                  fontSize: 25.sp, fontWeight: FontWeight.w700)),
              Gap(20.h,),
              Text.rich(
                TextSpan(                  
                  children: [
                    TextSpan(text: appService.getTrans('By connecting your wallet, you agree to our '), 
                      style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp),
                    ),
                    TextSpan(text: appService.getTrans('Terms of Service'), 
                      style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp, fontWeight: FontWeight.w700),
                    ),    
                    TextSpan(text: appService.getTrans(' and our '), 
                      style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp),
                    ),
                    TextSpan(text: appService.getTrans('Privacy policy'), 
                      style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp, fontWeight: FontWeight.w700),
                    ),
                  ],                  
                ),
                textAlign: TextAlign.center,
              ),
              Gap(20.h),
              _getWalletConnectItem("playground/rainbow.png", "Rainbow"),
              _getWalletConnectItem("playground/coinbase.png", "Coinbase"),
              _getWalletConnectItem("playground/metamask.png", "Metamask"),
              Gap(30.h)
            ],
          ),
        )                      
      ),
      isScrollControlled: true,
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
              child: Text(appService.getTrans(label), style: TextStyle(color: AppColors.fontPrimary,
                fontSize: 18.sp, fontWeight: FontWeight.w700)
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
              Text(appService.getTrans("This page will open another application.")),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                  await appService.signIn();
                  await appService.getMineInfo();
                }, 
                style:  ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),                    
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.fontPrimary,
                  textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  minimumSize: Size(200.w, 40.h)
                ),
                child: Text(appService.getTrans("Open"))
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
                  textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  minimumSize: Size(200.w, 40.h)
                ),
                child: Text(appService.getTrans("Cancel"))
              ),
            ]
          )
        )
      );
    });
  }
}