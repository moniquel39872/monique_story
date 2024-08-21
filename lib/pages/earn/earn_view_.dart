import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/model/earn_list_model.dart';
import 'package:kombat_flutter/pages/earn/widgets/earn_list_item_widget.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/app_bottomsheet_widget.dart';
import 'package:kombat_flutter/widget/first_animator_widget.dart';
import 'package:kombat_flutter/widget/wave_widget.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class EarnView extends StatefulWidget {
  const EarnView({super.key});

  @override
  State<EarnView>  createState() => _EarnViewState();
}

class _EarnViewState extends State<EarnView> {
  final AppService appService = Get.find<AppService>();
  bool _isFirstLoad = true;
  
  final List<EarnListModel> youtubes = [
    EarnListModel(
        id: '1',
        title: 'GameStop The Power of The Community',
        bonus: 100000,
        image: "youtube.png",
        path: ""),
    EarnListModel(
        id: '2',
        title: '5 richest people in the world',
        bonus: 100000,
        image: "youtube.png",
        path: ""),
  ];

  final List<EarnListModel> dailyTasks = [
    EarnListModel(
        id: '1',
        title: 'Daily reward',
        bonus: 6649000,
        image: "mine/bitcoin_day.png",
        path: ""),
  ];

  final List<EarnListModel> tasks = [
    EarnListModel(
        id: '1',
        title: 'Join our TG channel',
        bonus: 5000,
        image: "tg.png",
        path: ""),
    EarnListModel(
        id: '2',
        title: 'Follow our X account',
        bonus: 5000,
        image: "x_account.png",
        path: ""),
    EarnListModel(
        id: '3',
        title: 'Choose your exchange',
        bonus: 5000,
        image: "mine/avatar0.png",
        path: ""),
    EarnListModel(
        id: '4',
        title: 'Invite 3 friends',
        bonus: 25000,
        image: "invite.png",
        path: ""),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFirstLoad = appService.firstLoad['earn']??true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appService.firstLoad['earn']=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(100.h,),
          FirstAnimatorWidget(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(
              curve: Curves.elasticInOut,
              duration: const Duration(milliseconds: 600),
            ), 
            isAnimate: _isFirstLoad, 
            child: AppImage.asset('mine/shining_coin.png')// WaveWidget(image: 'coin1.png'),
          ),
          Gap(20.h,),
          FirstAnimatorWidget(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
              curve: Curves.elasticInOut,
              duration: const Duration(milliseconds: 900),
            ), 
            isAnimate: _isFirstLoad, 
            child: Text(appService.getTrans('Earn more coins'),
              style: TextStyle(fontSize: 40.sp),
            ),
          ),         
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
                  child: Text('Hamster Youtube',
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
                ...List.generate(youtubes.length, (index) {
                  return EarnListItemWidget(
                    isAnimate: _isFirstLoad,
                    item: youtubes[index],
                    onPressed: () {
                      Get.bottomSheet(
                        AppBottomsheetWidget(
                          child: Column(
                            children: [
                              AppImage.asset('youtube.png',
                                  width: 60.w, height: 60.w),
                              Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(appService.getTrans('Your first steps in Crypto & Stock trading'),
                                  style: TextStyle(fontSize: 40.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: 50.w),
                                child: Text(appService.getTrans('Trading basics for stocks and crypto : Step guide'),
                                  style: TextStyle(fontSize: 18.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Gap(10.w,),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 4.w,
                                  horizontal: 15.w,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.w,
                                  horizontal: 40.w,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xff5A60FF),
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                                child: Text(appService.getTrans('Watch video')),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    AppImage.asset('mine/coin.png', width: 20.w, height: 20.w,),
                                    Gap( 5.w,),
                                    Text.rich(
                                      TextSpan(
                                        text: " +100,000",
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 4.w,
                                  horizontal: 15.w,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 30.w,
                                  horizontal: 40.w,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xff5A60FF),
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                                child: Text(appService.getTrans('Check'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Gap(30.h,),
                            ],
                          ),
                        ),
                        isScrollControlled: false,
                      );
                    }
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
                  child: Text(appService.getTrans('Daily reward'),
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
                ...List.generate(dailyTasks.length, (index) {
                  return EarnListItemWidget(
                    isAnimate: _isFirstLoad,
                    item: dailyTasks[index], 
                    onPressed: () {}
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
                  child: Text(appService.getTrans('Tasks list'),
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
                ...List.generate(tasks.length, (index) {
                  return EarnListItemWidget(
                    isAnimate: _isFirstLoad,
                    item: tasks[index], 
                    onPressed: () {}
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
