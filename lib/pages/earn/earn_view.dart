import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/pages/earn/model/earn_list_model.dart';
import 'package:kombat_flutter/pages/earn/widgets/earn_list_item_widget.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/app_bottomsheet_widget.dart';
import 'package:kombat_flutter/widget/wave_widget.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class EarnView extends StatefulWidget {
  const EarnView({Key? key}) : super(key: key);

  @override
  _EarnViewState createState() => _EarnViewState();
}

class _EarnViewState extends State<EarnView> {
  final List<EarnListModel> youtubes = [
    EarnListModel(
        id: '1',
        title: 'GameStop The Power of The Community',
        bonus: "100,000",
        image: "youtube.png",
        path: ""),
    EarnListModel(
        id: '2',
        title: '5 richest people in the world',
        bonus: "100,000",
        image: "youtube.png",
        path: ""),
  ];

  final List<EarnListModel> dailyTasks = [
    EarnListModel(
        id: '1',
        title: 'Daily reward',
        bonus: "6,649,000",
        image: "daily_reward.png",
        path: ""),
  ];

  final List<EarnListModel> tasks = [
    EarnListModel(
        id: '1',
        title: 'Join our TG channel',
        bonus: "5,000",
        image: "tg.png",
        path: ""),
    EarnListModel(
        id: '2',
        title: 'Follow our X account',
        bonus: "5,000",
        image: "x_account.png",
        path: ""),
    EarnListModel(
        id: '3',
        title: 'Choose your exchange',
        bonus: "5,000",
        image: "avatar0.png",
        path: ""),
    EarnListModel(
        id: '4',
        title: 'Invite 3 friends',
        bonus: "25,000",
        image: "invite.png",
        path: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(
              curve: Curves.elasticInOut,
              duration: const Duration(milliseconds: 600),
            ),
            child: const WaveWidget(image: 'coin1.png'),
          ),
          SizedBox(
            height: 20.h,
          ),
          WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
              curve: Curves.elasticInOut,
              duration: const Duration(milliseconds: 900),
            ),
            child: Text(
              'Earn more coins',
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
                  child: Text(
                    'Hamster Youtube',
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
                ...List.generate(youtubes.length, (index) {
                  return EarnListItemWidget(
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
                                  child: Text(
                                    'Your first steps in Crypto & Stock trading',
                                    style: TextStyle(fontSize: 40.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 50.w),
                                  child: Text(
                                    'Trading basics for stocks and crypto : Step guide',
                                    style: TextStyle(fontSize: 18.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
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
                                    color: Color(0xff5A60FF),
                                    borderRadius: BorderRadius.circular(20.w),
                                  ),
                                  child: Text('Watch video'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AppImage.asset(
                                        'coin.png',
                                        width: 20.w,
                                        height: 20.w,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
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
                                    color: Color(0xff5A60FF),
                                    borderRadius: BorderRadius.circular(20.w),
                                  ),
                                  child: Text(
                                    'Check',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                              ],
                            ),
                          ),
                          isScrollControlled: false,
                        );
                      });
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
                  child: Text(
                    'Daily reward',
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
                ...List.generate(dailyTasks.length, (index) {
                  return EarnListItemWidget(
                      item: dailyTasks[index], onPressed: () {});
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
                  child: Text(
                    'Tasks list',
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
                ...List.generate(tasks.length, (index) {
                  return EarnListItemWidget(
                      item: tasks[index], onPressed: () {});
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
