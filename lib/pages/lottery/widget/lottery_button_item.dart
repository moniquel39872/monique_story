import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/pages/lottery/lottery_controller.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class LotteryButtonItem extends StatefulWidget {
  LotteryButtonItem({
    super.key, 
    required this.index,
    required this.icon, 
    required this.label, 
    required this.onPressed, 
    this.isSelected
  });
  int index;
  final String icon;
  final String label;
  final VoidCallback onPressed;
  bool? isSelected;

  @override
  State<LotteryButtonItem> createState() => _LotteryButtonItemState();
}

class _LotteryButtonItemState extends State<LotteryButtonItem>{
  AppService appService = Get.find();
  LotteryController controller = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Obx(()=>GestureDetector(
      onTap: (widget.index==controller.selectedIndex.value)? widget.onPressed: null,
      child: Column(
        children: [
          Opacity(
            opacity: widget.index!=controller.selectedIndex.value?0.7:1,
            child: AppImage.asset('playground/${widget.icon}.png', height: 60.h),
          ),
          (widget.index!=controller.selectedIndex.value)?
            Text(appService.getTrans(widget.label), style:TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp))
            :
            Container()
        ],
      )
    ));
  }
}