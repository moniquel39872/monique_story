import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/pages/earn/model/earn_list_model.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/first_animator_widget.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

// ignore: must_be_immutable
class EarnListItemWidget extends StatelessWidget {
  EarnListItemWidget(
      {super.key, required this.item, required this.onPressed, required this.isAnimate});
  final EarnListModel item;
  final VoidCallback onPressed;
  final bool isAnimate;

  AppService appService = Get.find<AppService>();

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
            FirstAnimatorWidget(
              incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                curve: Curves.elasticInOut,
                duration: const Duration(milliseconds: 500),
              ),
              isAnimate: isAnimate, 
              child:  AppImage.asset('${item.image}', width: 50.w, height: 50.w),
            ),           
            Gap(10.w,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appService.getTrans("${item.title}"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  Gap(10.h,),
                  Row(
                    children: [
                      Icon(
                        Icons.brightness_1_sharp,
                        size: 8.w,
                        color: Colors.yellow,
                      ),
                      Gap(5.w,),
                      AppImage.asset(
                        'coin.png',
                        width: 20.w,
                        height: 20.w,
                      ),
                      Gap(5.w,),
                      Text.rich(
                        TextSpan(
                          text: " +${item.bonus}",
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
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.fontSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
