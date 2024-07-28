import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kombat_flutter/pages/earn/model/earn_list_model.dart';
import 'package:kombat_flutter/pages/earn/widgets/earn_list_item_widget.dart';
import 'package:kombat_flutter/utils/app_image.dart';
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
        image: "avatar3.png",
        path: ""),
    EarnListModel(
        id: '2',
        title: '5 richest people in the world',
        bonus: "100,000",
        image: "avatar3.png",
        path: ""),
  ];

  final List<EarnListModel> dailyTasks = [
    EarnListModel(
        id: '1',
        title: 'Daily reward',
        bonus: "6,649,000",
        image: "avatar3.png",
        path: ""),
  ];

  final List<EarnListModel> tasks = [
    EarnListModel(
        id: '1',
        title: 'Join our TG channel',
        bonus: "5,000",
        image: "avatar3.png",
        path: ""),
    EarnListModel(
        id: '2',
        title: 'Follow our X account',
        bonus: "5,000",
        image: "avatar3.png",
        path: ""),
    EarnListModel(
        id: '3',
        title: 'Choose your exchange',
        bonus: "5,000",
        image: "avatar3.png",
        path: ""),
    EarnListModel(
        id: '4',
        title: 'Invite 3 friends',
        bonus: "25,000",
        image: "avatar3.png",
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
              duration: Duration(milliseconds: 600),
            ),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFDD756).withOpacity(0.6),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffFDD756).withOpacity(0.6),
                    blurRadius: 2,
                    blurStyle: BlurStyle.outer,
                  ),
                  BoxShadow(
                    offset: Offset(1, 1),
                    color: Color(0xffFDD756),
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: AppImage.asset('coin.png',
                  width: 200.w, height: 200.w, fit: BoxFit.fill),
            ),
          ),
          WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
              curve: Curves.elasticInOut,
              duration: Duration(milliseconds: 900),
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
                      item: youtubes[index], onPressed: () {});
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
