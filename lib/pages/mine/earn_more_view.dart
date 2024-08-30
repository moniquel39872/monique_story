import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/model/daily_task_model.dart';
import 'package:kombat_flutter/model/earn_list_model.dart';
import 'package:kombat_flutter/pages/earn/widgets/earn_list_item_widget.dart';
import 'package:kombat_flutter/pages/mine/mine_view_controller.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/app_bottomsheet_widget.dart';
import 'package:kombat_flutter/widget/app_toast.dart';
import 'package:kombat_flutter/widget/first_animator_widget.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class EarnMoreView extends StatefulWidget {
  const EarnMoreView({super.key});

  @override
  State<EarnMoreView> createState() => _EarnMoreViewState();
}

class _EarnMoreViewState extends State<EarnMoreView> with TickerProviderStateMixin  {
  final AppService appService = Get.find<AppService>();
  MineViewController controller = Get.find();
  bool _isFirstLoad = true;
  int _selectedIndex = -1;
  
  final List<EarnListModel> dailyTasks = [
    EarnListModel(
      id: '1',
      title: 'Daily reward',
      bonus: 6649000,
      image: "mine/bitcoin_day.png",
      path: ""
    ),
  ];

  // final List<DailyRewardsModel> dailyRewards = [
  //   DailyRewardsModel(title: "Day1", coins: "500", isEnable: true),
  //   DailyRewardsModel(title: "Day2", coins: "1K", isEnable: false),
  //   DailyRewardsModel(title: "Day3", coins: "2K", isEnable: false),
  //   DailyRewardsModel(title: "Day4", coins: "3K", isEnable: false),
  //   DailyRewardsModel(title: "Day5", coins: "4K", isEnable: false),
  //   DailyRewardsModel(title: "Day6", coins: "5K", isEnable: false),
  //   DailyRewardsModel(title: "Day7", coins: "6K", isEnable: false),
  //   DailyRewardsModel(title: "Day8", coins: "7K", isEnable: false),
  //   DailyRewardsModel(title: "Day9", coins: "8K", isEnable: false),
  //   DailyRewardsModel(title: "Day10", coins: "10K", isEnable: false),
  // ];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFirstLoad = appService.firstLoad['earn']??true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appService.firstLoad['earn']=false;
    });
    controller.getDailyTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FirstAnimatorWidget(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(
                curve: Curves.elasticInOut,
                duration: const Duration(milliseconds: 600),
              ), 
              isAnimate: _isFirstLoad, 
              child: AppImage.asset('mine/shining_coin.png', width: 350.w)// WaveWidget(image: 'coin1.png'),
            ),
            FirstAnimatorWidget(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                curve: Curves.elasticInOut,
                duration: const Duration(milliseconds: 900),
              ), 
              isAnimate: _isFirstLoad, 
              child: Text(appService.getTrans('Earn more coins'),
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                    child: Text(appService.getTrans('Daily task'),
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  ...List.generate(dailyTasks.length, (index) {
                    return EarnListItemWidget(
                      isAnimate: _isFirstLoad,
                      item: dailyTasks[index], 
                      onPressed: () {
                        showBottomSheet();
                      }
                    );
                  }),
                ],
              ),
            ), 
          ]
        )
      ) 
    );
  }

  bool _checkEnableTask() {
    bool result = false;
    for(int i=0;i<controller.dailyTasks.length;i++) {
      if(controller.dailyTasks[i].isCompleted==false) {
        result = true;
        break;
      }
    }
    return result;
  }

  void showBottomSheet() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: ( BuildContext context ) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return 
              AppBottomsheetWidget(
                topImage: AppImage.asset('mine/daily_reward1.png', width: 250.w),
                child: Column(
                  children: [   
                    Gap(150.h),
                    Container(
                      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 0.h),
                      child: Text(appService.getTrans('Daily reward'),
                        style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Text(appService.getTrans('Accure coins for logging into the game daily without skipping'),
                        style: TextStyle(fontSize: 17.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gap(15.h,),
                    GridView.count(
                      crossAxisCount: 4,
                      primary: false,
                      shrinkWrap: true,
                      mainAxisSpacing: 10.w,
                      crossAxisSpacing: 10.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      children: [
                        ...List.generate(10, (index){
                          DailyTaskModel item = index<controller.dailyTasks.length?controller.dailyTasks[index]:DailyTaskModel();
                          return GestureDetector(
                            onTap: item.id==null ? null: () {
                              if(item.isCompleted==false) {
                                setState(() {                         
                                  item.isSelected=true;
                                  _selectedIndex = index;
                                });
                              }
                            },
                            child: Opacity(opacity: (item.id!=null)?1.0:0.3,
                              child: Container( 
                                decoration: item.isCompleted==true? 
                                BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.w),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0xff98e7a0), Color(0xff43894a),],
                                  )
                                ):
                                BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.w),
                                  color: AppColors.secondary,
                                  border: item.isSelected==true
                                    ?Border.all(color: AppColors.fontMenu3, width: 1.h):Border.all(color: Colors.transparent)
                                ),
                                child: item.id!=null? Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('${item.taskType}', style: TextStyle(color: AppColors.fontPrimary, fontSize: 15.sp)),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xffffffff).withOpacity(0.3),
                                            spreadRadius: 0.3,
                                            blurRadius: 0.3,
                                            offset: const Offset(0, 0), // changes position of shadow
                                          ),
                                        ],
                                      ),                                      
                                      child: AppImage.asset('mine/coin.png', width: 40.w),
                                    ),
                                    Text('${item.points}', 
                                      style:TextStyle(color: AppColors.fontPrimary, fontSize: 15.sp, fontWeight: FontWeight.w700)
                                    )
                                  ]
                                ): Container()
                              )
                            )
                          );
                        })
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: ElevatedButton(
                        onPressed: _selectedIndex>-1?() async{
                          DailyTaskModel item = controller.dailyTasks[_selectedIndex];                          
                          if(item.isCompleted==false){
                            bool result = await controller.completeSigninTask();
                            if(result) {
                              setState((){
                                item.isCompleted = true;
                                _selectedIndex = -1;
                              });
                            } else {
                              AppToast.showError(msg: appService.getTrans("Can't complete this task"));
                            }
                          }                          
                        }:null, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff5A60FF),
                          disabledBackgroundColor: AppColors.secondary,
                          disabledForegroundColor: AppColors.fontSecondary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
                          foregroundColor: Colors.white,
                          minimumSize: Size.fromHeight(60.h)
                        ),
                        child: Text(appService.getTrans(_checkEnableTask()?'Claim':'Come back tomorrow'), 
                          style:TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700), textAlign: TextAlign.center
                        )
                      ),
                    )
                  ],
                ),
              );
          }
        );
      }
      // isScrollControlled: true,
    );
  }
}