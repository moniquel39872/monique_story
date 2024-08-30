import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/model/backpack_model.dart';
import 'package:kombat_flutter/model/exchange_model.dart';
import 'package:kombat_flutter/pages/exchange/exchange1_controller.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_icons.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/utils/app_utils.dart';
import 'package:kombat_flutter/widget/app_bottomsheet_widget.dart';
import 'package:kombat_flutter/widget/app_common_dialog.dart';
import 'package:kombat_flutter/widget/app_toast.dart';
import 'package:kombat_flutter/widget/first_animator_widget.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class ExchangeView extends StatefulWidget {
  const ExchangeView({super.key});

  @override
  State<ExchangeView> createState() => _ExchangeViewState();
}

class _ExchangeViewState extends State<ExchangeView> {
  AppService appService = Get.find<AppService>();
  ExchangeController controller = Get.put(ExchangeController());
  bool _isFirstLoad = true;
  final RxInt _tabIndex = 0.obs;
  final RxBool _isSent = false.obs;

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFirstLoad = appService.firstLoad['exchange']??true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appService.firstLoad['exchange']=false;
    });

    controller.getExchanges();
    _isSent.value = false;    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(()=>Stack(
        children: [
          SingleChildScrollView(
            child: Obx(()=>Column(
              children: [
                Gap(80.h),
                FirstAnimatorWidget(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(
                    curve: Curves.elasticInOut,
                    duration: const Duration(milliseconds: 600),
                  ), 
                  isAnimate: _isFirstLoad, 
                  child: AppImage.asset('exchange/coins.png', height: 200.h),  
                ),          
                Gap(20.h,),
                FirstAnimatorWidget(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                    curve: Curves.elasticInOut,
                    duration: const Duration(milliseconds: 600),
                  ),
                  isAnimate: _isFirstLoad,
                  child: Text(AppUtils.intToStrWithComma(appService.mineInfoModel.value?.gold??0),
                    style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w700),
                  ),
                ),          
                Gap(30.h),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        _tabIndex.value=0;
                        controller.getExchanges();
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _tabIndex.value==0?AppColors.cardBackground: AppColors.background
                      ),
                      child: Row(children: [
                        Text(appService.getTrans('Limited Exchange'), style: TextStyle(color: AppColors.fontPrimary, fontSize: 20.sp)),
                        Gap(5.w),
                        Icon(AppIcons.question_circle_o , color: AppColors.fontSecondary, size: 20.w)
                      ],)                  
                    ),
                    Gap(10.w),
                    ElevatedButton(
                      onPressed: (){
                        _tabIndex.value=1;
                        controller.getBackpack();
                      },  
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _tabIndex.value==1?AppColors.cardBackground: AppColors.background
                      ),
                      child: Row(children: [
                        Text(appService.getTrans('Backpack'), style: TextStyle(color: AppColors.fontPrimary, fontSize: 20.sp)),
                      ],)                  
                    )
                  ],
                ),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.w,
                  crossAxisSpacing: 15.w,
                  childAspectRatio: 0.8,
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  children: 
                  _tabIndex.value==0 ?
                  [
                    ...List.generate(controller.exchangeList.length, (index){
                      return _getExchangeItem(controller.exchangeList.value[index]);
                    })
                  ]:
                  [
                    ...List.generate(controller.backpackList.length, (index){
                      return _getBackpackItem(controller.backpackList.value[index]);
                    })
                  ],
                )
              ],
            )),
          ),
          if(_isSent.value)
          GestureDetector(
            onTap: ()=>_isSent.value=false,
            child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingScaleDown(
                curve: Curves.elasticInOut,
                duration: const Duration(milliseconds: 2000),
              ),
              child: Container(               
                alignment: Alignment.center,
                width: Get.width, height: Get.height,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: ExactAssetImage('assets/images/exchange/got.png'),
                  ),
                  color: Colors.black.withOpacity(0.9)
                ),
                child: Column(children: [Gap(550.h),
                  Text(appService.getTrans('Your backpack has been delivered'), 
                    style: TextStyle(color: AppColors.fontPrimary, fontSize: 20.sp)
                  )
                ])
              )
            )
          )
        ],
      ))
    );
  }

  Widget _getExchangeItem(ExchangeModel item) {
    String button = 'Get';    
    bool enable = true;
    if(item.status==0){
      button = 'Completed';
      enable = false;
    } else if(item.price>appService.getCurrentGolds()) {
      button = 'Not enough';
      enable = false;
    }
    String desc = "", times = 'times';
    if(item.amountLimit>0) {
      if(item.amountLimit==1) {
        times = 'time';
      }
      desc = "${item.amountLimit} $times Limited";
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.w),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff414347), Color(0xff1c1f24),],
        )
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Expanded(child:
          Center(child: AppImage.asset('exchange/${item.symbol}.png', width: 80.w)),
        ),
        Text('${double.parse(item.amount).toPrecision(2)} ${item.name}', style: TextStyle(color: AppColors.fontPrimary, fontSize: 22.sp)),
        Gap(10.h),
        Text(desc, style: TextStyle(color: AppColors.fontSecondary, fontSize: 18.sp)),
        Gap(20.h),
        Row(children: [
          AppImage.asset('mine/coin.png', width: 25.w),
          Gap(5.w),
          Text(AppUtils.intToStrWithComma(item.price), style: TextStyle(color: AppColors.fontPrimary, fontSize: 17.sp))
        ],),
        ElevatedButton(
          onPressed: (){
            if(enable) {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                  AppCommonDialog(                    
                    msg: 'You will exchange ${AppUtils.intToStrWithComma(item.price)} to your backpack.',
                    cancelLabel: 'Later',
                    onOk: () async {
                      Navigator.pop(context);
                      bool result = await controller.exchangeTrade(item.id, item.price);
                      if(result) {
                        _isSent.value=true;     
                        Future.delayed(const Duration(milliseconds: 3500), ()=>_isSent.value=false);
                      } else {
                        AppToast.showError(msg: appService.getTrans('Request Failed'));
                      }                      
                    },
                    onCancel: ()=>Navigator.pop(context),
                  )
              );
            }
          }, 
          style: ElevatedButton.styleFrom(
            backgroundColor: enable==false ? AppColors.fontSecondary: AppColors.buttonBackground,
            padding: EdgeInsets.zero,
            minimumSize: Size.fromHeight(40.h)
          ),                          
          child: Text(appService.getTrans(button), style: TextStyle(color: AppColors.fontPrimary, fontSize: 15.sp))
        )
      ],)
    );
  }

  Widget _getBackpackItem(BackpackModel item) {
    //status 状态:-0禁用，1可用，2已提现，3申请中，4处理中，5异常
    String button = 'Withdrawal';
    switch(item.status) {
      case 0:
      button = 'Disabled';
      break;
      case 1:
      button = 'Withdrawal';
      break;
      case 2:
      button = 'Withdrawn';
      break;
      case 3:
      button = 'Applying';
      break;
      case 4:
      button = 'Processing';
      break;
      case 5:
      button = 'Abnormal';
      break;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.w),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff414347), Color(0xff1c1f24),],
        )
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Expanded(child:
          AppImage.asset('exchange/${item.symbol}.png', width:80.w),
        ),
        Text('${double.parse(item.amount).toPrecision(2)} ${item.name}', style: TextStyle(color: AppColors.fontPrimary, fontSize: 22.sp)),
        Gap(20.h),
        ElevatedButton(
          onPressed: (){
            if(item.status==1) {
              _openBottomSheet(item);
            }
          }, 
          style: ElevatedButton.styleFrom(
            backgroundColor: item.status!=1? AppColors.fontSecondary: AppColors.buttonBackground,
            padding: EdgeInsets.zero,
            minimumSize: Size.fromHeight(40.h)
          ),                          
          child: Text(appService.getTrans(button), style: TextStyle(color: AppColors.fontPrimary, fontSize: 15.sp))
        )
      ],)
    );
  }
  
  void _openBottomSheet(BackpackModel item) {
    textEditingController1.text = appService.walletAddress;
    textEditingController2.text="";
    Get.bottomSheet(
      AppBottomsheetWidget(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage.asset('exchange/${item.symbol}.png', width: 100.w),
                  Text('${double.parse(item.amount).toPrecision(2)} ${item.name}', style: TextStyle(color: AppColors.fontPrimary,
                    fontSize: 23.sp, fontWeight: FontWeight.w700)),  
                ]
              ), 
              Gap(20.h,),
              Text(appService.getTrans('To Dress: '), style: TextStyle(color: AppColors.fontPrimary,
                  fontSize: 18.sp)),
              Gap(10.h),
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: AppColors.secondary,
                ),
                child: TextField(
                  controller: textEditingController1,
                  style: TextStyle(color: AppColors.fontPrimary, fontSize: 17.sp) ,
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                    border: InputBorder.none,                      
                  ),
                ),
              ),
              Gap(20.h),
              Text(appService.getTrans('Message: '), style: TextStyle(color: AppColors.fontPrimary,
                  fontSize: 18.sp)),
              Gap(10.h),
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: AppColors.secondary,
                ),
                child: TextField(
                  controller: textEditingController2,
                  style: TextStyle(color: AppColors.fontPrimary, fontSize: 17.sp) ,
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                    border: InputBorder.none,                      
                  ),
                ),
              ),
              Gap(20.h),
              ElevatedButton(
                onPressed: () async {
                  String address = textEditingController1.text;
                  if(address=='') {
                    AppToast.showError(msg: appService.getTrans('Please enter address'));
                  }
                  bool result = await controller.withdrawal(item.id, address);
                  if(result) {
                    AppToast.showSuccess(msg: appService.getTrans('Successfully sent'));
                    Future.delayed(const Duration(seconds: 1), ()=>controller.getBackpack());
                  } else {
                    AppToast.showError(msg: appService.getTrans('Operation Failed'));
                  }
                  Navigator.of(context).pop();
                }, 
                style:  ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),                    
                  backgroundColor: AppColors.buttonBackground,
                  foregroundColor: AppColors.fontPrimary,
                  textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  minimumSize: Size.fromHeight(50.h)
                ),
                child: Text(appService.getTrans("Send"))
              )
            ],
          ),
        )                      
      ),
      isScrollControlled: true,
    );
  }

}
