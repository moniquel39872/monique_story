import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kombat_flutter/pages/airdrop/model/earn_list_model.dart';
import 'package:kombat_flutter/pages/airdrop/widgets/earn_list_item_widget.dart';
import 'package:kombat_flutter/pages/earn/widgets/earn_list_item_widget.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/wave_widget.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class AirdropView extends StatefulWidget {
  const AirdropView({Key? key}) : super(key: key);

  @override
  _AirdropViewState createState() => _AirdropViewState();
}

class _AirdropViewState extends State<AirdropView> {
  final List<AirdropListModel> tasks = [
    AirdropListModel(
        id: '1',
        title: 'Connect your TON wallet',
        bonus: "5,000",
        image: "ton_wallet.png",
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
            child: WaveWidget(image: 'airdrop1.png'),
            // Container(
            //   padding: EdgeInsets.all(20.w),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Color(0xffFDD756).withOpacity(0.6),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color(0xffFDD756).withOpacity(0.6),
            //         blurRadius: 2,
            //         blurStyle: BlurStyle.outer,
            //       ),
            //       const BoxShadow(
            //         offset: Offset(1, 1),
            //         color: Color(0xffFDD756),
            //         blurRadius: 1,
            //         blurStyle: BlurStyle.outer,
            //       ),
            //     ],
            //   ),
            //   child: AppImage.asset('airdrop1.png',
            //       width: 200.w, height: 200.w, fit: BoxFit.fill),
            // ),
          ),
          SizedBox(
            height: 20.h,
          ),
          WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
              curve: Curves.elasticInOut,
              duration: Duration(milliseconds: 600),
            ),
            child: Text(
              'Airdrop Tasks',
              style: TextStyle(fontSize: 40.sp),
            ),
          ),
          WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
              duration: Duration(milliseconds: 700),
              curve: Curves.elasticInOut,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                'Listing is on its way. Tasks will appear bello. Complete them to participate in the Airdrop',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
                textAlign: TextAlign.center,
              ),
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
                    'Task list',
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
                ...List.generate(tasks.length, (index) {
                  return AirdropListItemWidget(
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
