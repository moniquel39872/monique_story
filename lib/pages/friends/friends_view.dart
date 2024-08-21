import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_constant.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/model/friend_model.dart';
import 'package:kombat_flutter/pages/friends/friends_controller.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_date_util.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({super.key});

  @override
  State<FriendsView> createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView>  with TickerProviderStateMixin{
  AppService appService = Get.find<AppService>();
  FriendsController controller = Get.put(FriendsController());
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

    controller.getFriends();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Gap(30.h),
          TabBar(              
            controller: _tabController,
            isScrollable: true,
            physics: const ClampingScrollPhysics(),
            indicatorSize: TabBarIndicatorSize.label,
            tabAlignment: TabAlignment.start,
            labelStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700), 
            indicator: null,
            labelColor: AppColors.fontPrimary,
            indicatorColor: AppColors.buttonBackground,
            tabs: tabs,
          ),
          Obx(()=>Expanded(
            child: TabBarView(controller: _tabController, physics: const NeverScrollableScrollPhysics(),
              children: [
                controller.isLoading.value?
                Container() :
                ListView.builder(
                  itemCount: controller.friendsList.length,
                  itemBuilder: (BuildContext context, int index){
                    FriendModel item = controller.friendsList[index];
                    return _getFriendItem(item);
                  }
                )
              ]
            ),
          ))
        ]
      )
    );
  }

  Widget _getFriendItem(FriendModel item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        color: AppColors.cardBackground
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            CircleAvatar(
              backgroundImage: ExactAssetImage('assets/images/avatar/${item.avatar}.jpg'),
              radius: 30.w,
            ),            
            Gap(10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.userName, style: TextStyle(color: AppColors.fontPrimary, fontSize: 20.sp, fontWeight: FontWeight.w700)),
                Gap(5.h),
                Row(children: [
                  Container(
                    width: 7.w, height: 7.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(item.status==-1?0x80ffffff:0xFF84CB69).withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 0.3,
                          offset: const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color: Color(item.status==-1?0x80ffffff:0xFF84CB69)
                    ),
                  ),
                  Gap(10.w),
                  Text(AppDateUtil.YMdhms(item.updatedAt??item.createdAt), style: TextStyle(color: AppColors.fontSecondary, fontSize: 15.sp))
                ],)
              ],
            )
          ],),
          item.status==-1?
          AppImage.svgByAsset('add_friend.svg', height: 30.h, color: AppColors.fontSecondary):
          SizedBox(height: 30.w, width: 30.w)
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
              atRestEffect: WidgetRestingEffects.size(effectStrength: 0.76, duration: const Duration(milliseconds: 1100)),
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
