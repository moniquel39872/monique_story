import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/pages/lottery/lottery_controller.dart';
import 'package:kombat_flutter/pages/lottery/widget/lottery_button_item.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_date_util.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/app_bottomsheet_widget.dart';
import 'package:kombat_flutter/widget/app_common_dialog.dart';
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
  late final AnimationController _animController2;
  final CarouselController _carouselController = CarouselController();

  RxBool isWinning = false.obs;
  RxBool isFailed = false.obs;
  Timer? _timer;
  bool _isTimerRunning = false;
  Duration duration = const Duration(microseconds: 200);
  int initCarouselIndex = 0;

  void startTimer() {
    if (_isTimerRunning) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });

    setState(() {
      _isTimerRunning = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
    _animController2 = AnimationController(vsync: this);
    _animController2.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _animController2.reset();
      }
    });
    controller.addressEditingController.text = "9JvVRpmUPGkSqwtbwCPw2QvRX2EmNbRhjAaa5muqdakz";
    startTimer();
    controller.selectedIndex.value = 0;
    isWinning.value = false;
    isFailed.value = false;
    initCarouselIndex = appService.isLogin.value==true ? 2: 0;
    controller.selectedIndex.value = initCarouselIndex;
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
        child: Obx(()=>Stack(
          alignment: Alignment.center,
          children: [
            Column(children: [
              Gap(50.h),
              if(appService.mineInfoModel.value!=null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Row(children: [
                  CircleAvatar(                    
                    radius: 30.w,
                    backgroundImage: ExactAssetImage('assets/images/avatar/${appService.mineInfoModel.value?.avatar??0}.jpg'),        
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
                              Text('${double.parse(appService.mineInfoModel.value?.withdrawTotal??"0").toPrecision(2)} USDT', style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)),
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
                              Text(appService.getTrans(AppDateUtil.displayCloseTime(appService.mineInfoModel.value?.orderLimitTime??0)), style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)),
                            ]
                          )
                        ],)
                      ],
                    )
                  )
                ],)
              ),
              Gap(15.h),
              // if(appService.mineInfoModel.value!=null)
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 30.w),
              //   child: FAProgressBar(
              //     currentValue: appService.getLevelPercent(),
              //     backgroundColor: AppColors.progressBackground,
              //     border: Border.all(color: AppColors.progressBorder, width: 2.h),
              //     borderRadius: BorderRadius.circular(10.w),
              //     progressColor: AppColors.progress,
              //     size: 20.h
              //   ),
              // ),
              Expanded(
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/data.json',
                    controller: _animController,
                    width: 480.w,
                    onLoaded: (composition) {
                      duration = composition.duration;
                    },
                  ),
                )
              ),
              Obx(()=>Stack(alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      // Gap(10.h),
                      Container(
                        width: 110.w, height: 110.w,
                        padding: EdgeInsets.all(15.w),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/images/playground/frame.png')
                          )
                        ),                    
                      ),
                      Gap(5.h),
                      Text(appService.getTrans(controller.curItemLabel[controller.selectedIndex.value]), style:TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp)),
                      AppImage.asset('playground/arrow_top.png')
                    ],
                  ),
                  CarouselSlider(
                    options: CarouselOptions( 
                      height: 110.h,                   
                      viewportFraction: 0.333,
                      enlargeCenterPage: false,
                      initialPage: initCarouselIndex,
                      onPageChanged: (index, reason) {
                        controller.selectedIndex.value=index;
                      },
                    ),
                    carouselController: _carouselController,
                    items: [
                      LotteryButtonItem(icon: "connect", label: "Wallet", onPressed: openWalletBottomSheet, index: 0,),
                      LotteryButtonItem(icon: "order", label: "Order", index: 1,
                        onPressed: (){
                          appService.initEarnTabIndex = 0;
                          mainController.selectedPath.value=earnPath;
                        }
                      ),
                      LotteryButtonItem(icon: "main", label: "Lucky Time", index: 2,
                        onPressed: (){
                          openRechargeBottomSheet();                          
                        }
                      ),
                      LotteryButtonItem(icon: "earn", label: "Earn", index: 3,
                        onPressed: (){
                          appService.initEarnTabIndex = 1;
                          mainController.selectedPath.value=earnPath;
                        }
                      ),
                    ],
                  ),              
                ]
              ))
            ]),
            if(isWinning.value==true)
            getWinningPrompt(),
            if(isFailed.value==true)
            getFailedPrompt(),
          ])
        )
      )
    );
  }

  void openWalletBottomSheet() {
    Get.bottomSheet(
      AppBottomsheetWidget(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Column(
            children: [
              AppImage.asset('playground/icon2.png', width: 150.w),
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
              _getWalletConnectItem("playground/address.png", "Address", openLoginBottomSheet),
              _getWalletConnectItem("playground/rainbow.png", "Rainbow", confirmOpenApp),
              _getWalletConnectItem("playground/coinbase.png", "Coinbase", confirmOpenApp),
              _getWalletConnectItem("playground/metamask.png", "Metamask", confirmOpenApp),
              Gap(30.h)
            ],
          ),
        )                      
      ),
      isScrollControlled: true,
    );
  }

  Widget _getWalletConnectItem(String icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
      return AppCommonDialog(                    
        msg: appService.getTrans('This page will open another application.'),
        cancelLabel: 'Cancel',
        okLabel: appService.getTrans('Open'),
        onOk: () async {
          Navigator.of(context).pop();
          Navigator.pop(context);
          await appService.signIn(controller.addressEditingController.text);
          await appService.getMineInfo();  
        },
        onCancel: ()=>Navigator.pop(context),
      );      
    });
  }

  void openLoginBottomSheet() {
    Navigator.pop(context);
    Get.bottomSheet(
      AppBottomsheetWidget(
        isBack: true,
        onBack: (){
          Navigator.pop(context);
          openWalletBottomSheet();
        },
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Column(
            children: [
              AppImage.asset('playground/wallet.png', width: 150.w),
              Gap(20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(appService.getTrans('Address Login'), style: TextStyle(color: AppColors.fontPrimary,
                  fontSize: 18.sp)),
                ],
              ),              
              Gap(10.h),
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: AppColors.secondary,
                ),
                child: TextField(
                  controller: controller.addressEditingController,
                  style: TextStyle(color: AppColors.fontPrimary, fontSize: 17.sp) ,
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                    hintText: appService.getTrans("Enter your wallet address"),
                    hintStyle: const TextStyle(color: AppColors.fontSecondary),
                    border: InputBorder.none,                      
                  ),
                ),
              ),
              Gap(20.h),
              ElevatedButton(
                onPressed: () async {
                  String address = controller.addressEditingController.text;
                  if(address.isEmpty) {
                    AppToast.showError(msg: appService.getTrans('Please enter address'));
                  } else {
                    await appService.signIn(controller.addressEditingController.text);
                    await appService.getMineInfo();
                    _carouselController.animateToPage(2);
                    Navigator.pop(context);
                  }
                }, 
                style:  ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),                    
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.fontPrimary,
                  textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  minimumSize: Size.fromHeight(50.h)
                ),
                child: Text(appService.getTrans("Login"))
              ),
              Gap(20.h)
            ],
          ),
        )                      
      ),
      isScrollControlled: true,
    );
  }

  void openRechargeBottomSheet() {
    Get.bottomSheet(
      AppBottomsheetWidget(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Column(
            children: [
              AppImage.asset('playground/recharge.png', width: 150.w),
              Text(appService.getTrans('0.506 sol'), style: TextStyle(color: AppColors.fontPrimary,
                  fontSize: 25.sp, fontWeight: FontWeight.w700)),
              Gap(20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(appService.getTrans('Recharge amount'), style: TextStyle(color: AppColors.fontPrimary,
                  fontSize: 18.sp)),
                ],
              ),
              Gap(10.h),
              Container(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: AppColors.secondary,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.rechargeEditingController,
                        style: TextStyle(color: AppColors.fontPrimary, fontSize: 17.sp) ,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h),
                          hintText: appService.getTrans("Enter your recharge amount"),
                          hintStyle: const TextStyle(color: AppColors.fontSecondary),
                          border: InputBorder.none,                      
                        ),
                      ),
                    ),
                    Text('Sol', style: TextStyle(fontSize: 18.sp, color: AppColors.fontPrimary, fontWeight: FontWeight.bold),)
                  ],
                )                
              ),
              Gap(20.h),
              const Divider(color: AppColors.fontSecondary),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appService.getTrans('Handling Fees'), style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp),),                  
                  Text(appService.getTrans('0 Sol'), style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp),)
                ],
              ),
              Gap(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appService.getTrans('Estimated recharge'), style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp),),
                  Text(appService.getTrans('3 Sol'), style: TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp),)
                ],
              ),
              Gap(15.h),
              ElevatedButton(
                onPressed: () async {
                  String recharge = controller.rechargeEditingController.text;
                  if(recharge.isEmpty) {
                    AppToast.showError(msg: appService.getTrans('Please enter recharge amount'));
                  } else {    
                    bool result = await controller.recharge();
                    if(result) {
                      Navigator.pop(context);
                      playGame();
                    } else {
                      AppToast.showError(msg: appService.getTrans('Failed recharge'));
                    }
                  }
                }, 
                style:  ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),                    
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.fontPrimary,
                  textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  minimumSize: Size.fromHeight(50.h)
                ),
                child: Text(appService.getTrans("Confirm payment"))
              ),
              Gap(10.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                style:  ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),                    
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.fontPrimary,
                  textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  minimumSize: Size.fromHeight(50.h)
                ),
                child: Text(appService.getTrans("Cancel"))
              ),
              Gap(20.h)
            ],
          ),
        )                      
      ),
      isScrollControlled: true,
    );
  }

  void playGame() async {
    _animController
    ..duration = duration
    ..forward();
    Future.delayed(duration, () async {
      int result = await controller.getHomeGame();      
      if(result==1) {
        isWinning.value = true;
      } else if(result==0) {
        isFailed.value = false;
      }
    });
  }

  Widget getWinningPrompt() {
    return Container(
      width: Get.width, height: Get.height,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.9),
        image: const DecorationImage(
          image: ExactAssetImage('assets/images/playground/background.png'),
          fit: BoxFit.fill
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(20.h),
          Lottie.asset(
            'assets/lottie/game_coin.json',
            controller: _animController2,
            width: 400.w,
            onLoaded: (composition) {
              duration = composition.duration;
            },
          ),      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            AppImage.asset('playground/success.png', width: 80.w),
            Text('X 1.5', style: TextStyle(color: AppColors.iconColor, fontSize: 25.sp, fontWeight: FontWeight.bold, fontFamily: "SFUIText"),)
          ],),
          Text(appService.getTrans('Congratulations!\n You winning the prize.'), 
            style: TextStyle(color: AppColors.fontPrimary, fontSize: 22.sp),
            textAlign: TextAlign.center,
          )
        ]
      ),
    );
  }

  Widget getFailedPrompt() {
    return Container(
      width: Get.width, height: Get.height,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.9),
        image: const DecorationImage(
          image: ExactAssetImage('assets/images/playground/background.png'),
          fit: BoxFit.fill
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(20.h),
          Stack(
            alignment: Alignment.center,
            children:[
              AppImage.asset('mine/sunny.png', width: 400.w),
              AppImage.asset('playground/failed.png', width: 250.w),
            ]
          ),      
          Gap(20.h),
          Text(appService.getTrans("Sorry!\n You didn't win."), 
            style: TextStyle(color: AppColors.fontPrimary, fontSize: 22.sp),
            textAlign: TextAlign.center,
          )
        ]
      ),
    );
  }


}