import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_constant.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/model/friend_model.dart';
import 'package:kombat_flutter/pages/friends/invite_bonus_widget.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/first_animator_widget.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({super.key});

  @override
  State<FriendsView> createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView>  with TickerProviderStateMixin{
  AppService appService = Get.find<AppService>();
  late TabController _tabController;
  late List<Tab> tabs;
  bool _isFirstLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    tabs = <Tab> [Tab(text: appService.getTrans('Friends'))];
    _isFirstLoad = appService.firstLoad['friends']??true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appService.firstLoad['friends']=false;
    });

    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: 
        Column(
          children: [
            Gap(100.h,),
            FirstAnimatorWidget(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                  duration:const Duration(milliseconds: 500),
                  curve: Curves.elasticInOut),
              isAnimate: _isFirstLoad,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(appService.getTrans('Invite friends!'),
                  style: TextStyle(fontSize: 44.sp),
                ),
              ),
            ),
            FirstAnimatorWidget(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                duration: Duration(milliseconds: 700),
                curve: Curves.elasticInOut,
              ),
              isAnimate: _isFirstLoad,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(appService.getTrans('You and your friend will receive bonuses'),
                  style: TextStyle(fontSize: 22.sp),
                ),
              ),
            ),
            InviteBonusWidget(
              bonus: "5,000",
              title: 'Invite a friend',
              image: 'gift1.png',
              isAnimate: _isFirstLoad,
            ),
            InviteBonusWidget(
              bonus: "25,000",
              title: 'Invite a friend with Telegram Premium',
              image: 'gift2.png',
              isAnimate: _isFirstLoad,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(appService.getTrans('More bonuess'),
                style: TextStyle(
                  color: const Color(0xff5B61FF),
                  fontSize: 22.sp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appService.getTrans('List of your friends')),
                  GestureDetector(
                    onTap: () {},
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Icon(
                          Icons.replay_rounded,
                          color: Colors.white,
                          size: 30.w,
                        ),
                        Text(
                          '5',
                          style: TextStyle(color: Colors.white, fontSize: 10.w),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                vertical: 20.w,
                horizontal: 15.w,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 30.w,
                horizontal: 10.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Center(
                  child: Text(appService.getTrans("You haven't invited anyone yet"),
                style: const TextStyle(color: AppColors.fontSecondary),
              )),
            ),        
            FirstAnimatorWidget(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
                curve: Curves.elasticInOut,
                duration: const Duration(milliseconds: 800),
              ),
              isAnimate: _isFirstLoad,
              child: getInviteWidget()
            ),        
          ],
        )
    );
  }

  Widget getInviteWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: WidgetAnimator(
              atRestEffect: WidgetRestingEffects.size(effectStrength: 0.76, duration: Duration(milliseconds: 1100)),
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20.w,
                ),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Color(0xff5A60FF),
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(appService.getTrans('Invite a friend'),
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.person_add_alt_1,
                      color: Colors.white,
                      size: 22.sp,
                    )
                  ],
                ),
              ),
            ),
          ),
          Gap( 10.w,),
          GestureDetector(
            onTap: () {
              // toastification.showCustom(
              //   context: context,
              //   autoCloseDuration: const Duration(seconds: 3),
              //   alignment: Alignment.topCenter,
              //   builder:
              //       (BuildContext context, ToastificationItem holder) {
              //     return Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(40.w),
              //         color: const Color(0xff23262A).withOpacity(0.7),
              //       ),
              //       padding: EdgeInsets.all(16.w),
              //       margin: EdgeInsets.all(8.w),
              //       child: Stack(
              //         alignment: AlignmentDirectional.centerEnd,
              //         children: [
              //           Row(
              //             children: [
              //               Icon(
              //                 Icons.check_circle,
              //                 color: const Color(0xff82F88E),
              //                 size: 30.w,
              //               ),
              //               Gap( 20.w,),
              //               Text(appService.getTrans('Text copied!'),
              //                 style: TextStyle(fontSize: 20.w),
              //               ),
              //             ],
              //           ),
              //           Icon(
              //             Icons.close_outlined,
              //             color: Color(0xffB0B1B3),
              //             size: 20.w,
              //           )
              //         ],
              //       ),
              //     );
              //   },
              // );
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 20.w,
              ),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xff5A60FF),
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: const Icon(
                Icons.copy,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
