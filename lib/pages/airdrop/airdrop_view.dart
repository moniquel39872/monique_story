import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/pages/airdrop/model/earn_list_model.dart';
import 'package:kombat_flutter/pages/airdrop/widgets/earn_list_item_widget.dart';
import 'package:kombat_flutter/pages/earn/widgets/earn_list_item_widget.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/first_animator_widget.dart';
import 'package:kombat_flutter/widget/wave_widget.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class AirdropView extends StatefulWidget {
  const AirdropView({super.key});

  @override
  _AirdropViewState createState() => _AirdropViewState();
}

class _AirdropViewState extends State<AirdropView> {
  AppService appService = Get.find<AppService>();
  bool _isFirstLoad = true;

  final List<AirdropListModel> tasks = [
    AirdropListModel(
        id: '1',
        title: 'Connect your TON wallet',
        bonus: "5,000",
        image: "ton_wallet.png",
        path: ""),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFirstLoad = appService.firstLoad['airdrop']??true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appService.firstLoad['airdrop']=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(100.h),
          FirstAnimatorWidget(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(
              curve: Curves.elasticInOut,
              duration: const Duration(milliseconds: 600),
            ), 
            isAnimate: _isFirstLoad, 
            child: const WaveWidget(image: 'airdrop1.png'),  
          ),          
          Gap(20.h,),
          FirstAnimatorWidget(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
              curve: Curves.elasticInOut,
              duration: const Duration(milliseconds: 600),
            ),
            isAnimate: _isFirstLoad,
            child: Text(appService.getTrans('Airdrop Tasks'),
              style: TextStyle(fontSize: 40.sp),
            ),
          ),          
          FirstAnimatorWidget(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticInOut,
            ),
            isAnimate: _isFirstLoad,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(appService.getTrans('Listing is on its way. Tasks will appear bello. Complete them to participate in the Airdrop'),
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
                  child: Text(appService.getTrans('Task list'),
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
                ...List.generate(tasks.length, (index) {
                  return AirdropListItemWidget(
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
