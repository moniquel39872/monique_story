import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class InviteBonusWidget extends StatelessWidget {
  const InviteBonusWidget({
    Key? key,
    required this.bonus,
    required this.title,
    required this.image,
  }) : super(key: key);

  final String title;
  final String bonus;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4.w,
        horizontal: 15.w,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20.w,
        horizontal: 10.w,
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
            child: AppImage.asset(
              '${image}',
              width: 50.w,
              height: 50.w,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${title}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.brightness_1_sharp,
                    size: 8.w,
                    color: Colors.yellow,
                  ),
                  AppImage.asset(
                    'coin.png',
                    width: 30.w,
                    height: 30.w,
                  ),
                  Text.rich(
                    TextSpan(
                      text: " +${bonus}",
                      children: const [
                        TextSpan(
                          text: " for you and your friend",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
