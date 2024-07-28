import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kombat_flutter/pages/friends/invite_bonus_widget.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:toastification/toastification.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  // late Animation<Offset> _slideAnimation;
  // late AnimationController _controller;
  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   begin: Offset.zero,
  //   end: const Offset(1.5, 0.0),
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.elasticIn,
  // ));
  @override
  void initState() {
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 2000),
    // )..repeat(reverse: true);
    // _slideAnimation = Tween<Offset>(
    //   begin: const Offset(-1, 0),
    //   end: Offset.zero,
    // ).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: const Interval(.6875, 1.0, curve: Curves.fastOutSlowIn),
    //   ),
    // );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100.h,
        ),
        WidgetAnimator(
          incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
              duration: Duration(milliseconds: 500),
              curve: Curves.elasticInOut),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              'Invite friends!',
              style: TextStyle(fontSize: 44.sp),
            ),
          ),
        ),
        WidgetAnimator(
          incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
            duration: Duration(milliseconds: 700),
            curve: Curves.elasticInOut,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
              'You and your friend will receive bonuses',
              style: TextStyle(fontSize: 22.sp),
            ),
          ),
        ),
        const InviteBonusWidget(
          bonus: "5,000",
          title: 'Invite a friend',
          image: 'avatar3.png',
        ),
        const InviteBonusWidget(
          bonus: "25,000",
          title: 'Invite a friend with Telegram Premium',
          image: 'avatar3.png',
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Text(
            'More bonuess',
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
              const Text('List of your friends'),
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
          child: const Center(
              child: Text(
            'You haven\'t invited anyone yet',
            style: TextStyle(color: AppColors.fontSecondary),
          )),
        ),
        WidgetAnimator(
          incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
            curve: Curves.elasticInOut,
            duration: Duration(milliseconds: 800),
          ),
          child: Padding(
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
                          Text(
                            'Invite a friend',
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
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    toastification.showCustom(
                      context: context,
                      autoCloseDuration: const Duration(seconds: 3),
                      alignment: Alignment.topCenter,
                      builder:
                          (BuildContext context, ToastificationItem holder) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.w),
                            color: const Color(0xff23262A).withOpacity(0.7),
                          ),
                          padding: EdgeInsets.all(16.w),
                          margin: EdgeInsets.all(8.w),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: const Color(0xff82F88E),
                                    size: 30.w,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Text(
                                    'Text copied!',
                                    style: TextStyle(fontSize: 20.w),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.close_outlined,
                                color: Color(0xffB0B1B3),
                                size: 20.w,
                              )
                            ],
                          ),
                        );
                      },
                    );
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
          ),
        )
      ],
    );
  }
}
