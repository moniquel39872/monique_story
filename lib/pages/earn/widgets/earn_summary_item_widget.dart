import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class EarnSummaryItemWidget extends StatelessWidget {
  const EarnSummaryItemWidget({
    super.key,
    required this.index,
    this.prize = '',
    this.icon = '',
    this.label = '',
    this.isSelected = false,
    required this.onPressed,
  });

  final int index;
  final String prize;
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Opacity(
        opacity: isSelected ? 1 : 0.3,
        child: GestureDetector(
          onTap: onPressed,
          // onTap: () {
          //   // controller.earningIndex.value = index;
          //   // controller.chooseOrderLogs();
          // },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            height: 200.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.w),
                color: AppColors.cardBackground),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$prize USDT',
                  style:
                      TextStyle(color: AppColors.fontPrimary, fontSize: 20.sp),
                ),
                AppImage.asset(icon, height: 100.h),
                Text(
                  label,
                  style:
                      TextStyle(color: AppColors.fontPrimary, fontSize: 18.sp),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
