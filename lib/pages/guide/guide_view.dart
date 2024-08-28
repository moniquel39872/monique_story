import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_navigator.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/theme/app_colors.dart';

class GuideView extends StatelessWidget {
  GuideView({super.key});

  final AppService appService = Get.find<AppService>();
  final List<String> descriptions = [
    'Click the button to log in to your web3 wallet and participate in Lucky Twist Egg',
    'Currently, there are two ways to link your wallet. You can choose to enter the address link or directly click on the wallet link you own.',
    'You can see your earnings, next participation timeProgress of elimination.',
    'Here you can see the progress of your last 6 orders.',
    'Enter the correct Morse code to receive generous rewards .-.--',
    'Here you can see your revenue for each order, as well as order details.',
    'Here you can see your entire income situation, including total income, dividend income, and burn income.',
    'Here you can exchange the currency you get for generous gifts.',
  ];
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: Get.width, height: Get.height,
        child: CarouselSlider(
          options: CarouselOptions(     
            height: Get.height,        
            viewportFraction: 1,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            scrollPhysics: const NeverScrollableScrollPhysics() //disable scroll
          ),
          carouselController: _carouselController,          
          items: [
            getGuideWidget(
              index: 0,               
              topDesc: 375.h, 
              leftDesc: 210.w, 
              widthDesc: 220.w, 
              heightDesc: 100.h, 
              topNext: 300.h, 
              leftNext: 220.w, 
              labelButton: appService.getTrans('Next')
            ),            
            getGuideWidget(
              index: 1,               
              topDesc: 305.h, 
              leftDesc: 130.w, 
              widthDesc: 215.w, 
              heightDesc: 110.h, 
              topNext: 230.h, 
              leftNext: 220.w, 
              labelButton: appService.getTrans('Next')
            ),            
            getGuideWidget(
              index: 2,               
              topDesc: 530.h, 
              leftDesc: 130.w, 
              widthDesc: 225.w, 
              heightDesc: 75.h, 
              topNext: 630.h, 
              leftNext: 220.w, 
              labelButton: appService.getTrans('Next')
            ),            
            getGuideWidget(
              index: 3,               
              topDesc: 530.h, 
              leftDesc: 210.w, 
              widthDesc: 235.w, 
              heightDesc: 70.h, 
              topNext: 630.h, 
              leftNext: 220.w, 
              labelButton: appService.getTrans('Next')
            ),            
            getGuideWidget(
              index: 4,               
              topDesc: 460.h, 
              leftDesc: 100.w, 
              widthDesc: 225.w, 
              heightDesc: 75.h, 
              topNext: 560.h, 
              leftNext: 200.w, 
              labelButton: appService.getTrans('Next')
            ),            
            getGuideWidget(
              index: 5,               
              topDesc: 665.h, 
              leftDesc: 130.w, 
              widthDesc: 190.w, 
              heightDesc: 95.h, 
              topNext: 765.h, 
              leftNext: 175.w, 
              labelButton: appService.getTrans('Next')
            ),            
            getGuideWidget(
              index: 6,               
              topDesc: 445.h, 
              leftDesc: 165.w, 
              widthDesc: 245.w, 
              heightDesc: 95.h, 
              topNext: 565.h, 
              leftNext: 190.w, 
              labelButton: appService.getTrans('Next')
            ),            
            getGuideWidget(
              index: 7,               
              topDesc: 690.h, 
              leftDesc: 105.w, 
              widthDesc: 240.w, 
              heightDesc: 80.h, 
              topNext: 790.h, 
              leftNext: 200.w, 
              labelButton: appService.getTrans('Start')
            ),
          ],
        ),
      )
    );
  }

  Widget getGuideWidget({    
    required int index,    
    required double topDesc,
    required double leftDesc,
    required double widthDesc,
    required double heightDesc,
    required double topNext,
    required double leftNext,
    required String labelButton,}) {

    return SizedBox(
      width: Get.width, height: Get.height,
      child: Stack(
        alignment: Alignment.center,      
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/guide/$index.png'),
                fit: BoxFit.fill
              )
            ),
          ),
          Positioned(
            top: topDesc,
            left: leftDesc,
            child: SizedBox(
              width: widthDesc,
              height: heightDesc,
              child: Text(descriptions[index], style: TextStyle(color: AppColors.fontPrimary, fontSize: 15.sp))
            )
          ),
          Positioned(
            top: topNext,
            left: leftNext,
            child: InkWell(
              onTap:(){
                if(index<descriptions.length-1) {
                  _carouselController.animateToPage(index+1);
                } else {
                  appService.showGuide.value = false;
                  appService.setHotlineData();
                  AppNavigator.toNamed(homePath);
                }
              },
              child: Container(
                width: 100.w, height: 50.h,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 5.h),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/images/guide/next.png'),
                    fit: BoxFit.fill
                  )
                ),
                child: Text(labelButton, style: TextStyle(color: AppColors.fontPrimary, fontSize: 20.sp))
              )
            )
          )
        ],
      )
    );
  }
}
