import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kombat_flutter/pages/airdrop/model/earn_list_model.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class AirdropListItemWidget extends StatelessWidget {
  const AirdropListItemWidget(
      {Key? key, required this.item, required this.onPressed})
      : super(key: key);
  final AirdropListModel item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.symmetric(
          vertical: 4.w,
          horizontal: 15.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Row(
          children: [
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                curve: Curves.elasticInOut,
                duration: Duration(milliseconds: 500),
              ),
              child: AppImage.asset('${item.image}', width: 50.w, height: 50.w),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.title}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.brightness_1_sharp,
                  //       size: 8.w,
                  //       color: Colors.yellow,
                  //     ),
                  //     SizedBox(
                  //       width: 5.w,
                  //     ),
                  //     AppImage.asset(
                  //       'coin.png',
                  //       width: 20.w,
                  //       height: 20.w,
                  //     ),
                  //      SizedBox(
                  //       width: 5.w,
                  //     ),
                  //     Text.rich(
                  //       TextSpan(
                  //         text: " +${item.bonus}",
                  //         children: const [
                  //           TextSpan(
                  //             text: " for you and your friend",
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ],
                  //         style: TextStyle(
                  //           color: Colors.yellow,
                  //           fontSize: 16.sp,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.fontSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
