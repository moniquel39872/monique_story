// ignore_for_file: deprecated_member_use
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_popup_card/flutter_popup_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/pages/mine/mine_view_controller.dart';
import 'package:kombat_flutter/pages/mine/widget/code_cracked_widget.dart';
import 'package:kombat_flutter/pages/mine/widget/code_popup_widget.dart';
import 'package:kombat_flutter/pages/mine/widget/daily_item_button_widget.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_icons.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/utils/app_utils.dart';
import 'package:kombat_flutter/widget/app_common_dialog.dart';
import 'package:kombat_flutter/widget/app_positioned_background.dart';
import 'package:kombat_flutter/widget/app_toast.dart';
import 'dart:math' as math;

import 'package:kombat_flutter/widget/core_button.dart';
import 'package:kombat_flutter/widget/first_animator_widget.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class MineView extends StatefulWidget {
  const MineView({required GlobalKey key}) : super(key: key);

  @override
  State<MineView> createState() => MineViewState();
}

class MineViewState extends State<MineView> with TickerProviderStateMixin  {
  final MainController mainController = Get.find();
  final AppService appService = Get.find<AppService>();
  final MineViewController controller = Get.put(MineViewController());
  
  late final AnimationController _coinsController;  
  Offset _startPos = Offset(100.w, 100.w);
  final List<Widget> _coinList = [];  
  int _stepCoins = 1;
  int duration = 200;
  final GlobalKey mainCoinKey = GlobalKey();
  late int _startScore = appService.getCurrentGolds(), _endScore = _startScore;
  final RxBool _isMultiCoins = false.obs;  
  final RxBool _isLoading = true.obs;
  final RxBool _isCrackedMorseCode = false.obs;
  bool _isFirstLoad = true;
  List<Widget> _morseCodes = [];

  void _startSingleAnim({TapDownDetails? tapDownDetails, LongPressEndDetails? longPressEndDetails, bool? isVibration=true}) {
    if(isVibration == true){
      appService.vibrate();
    }

    bool isLongPress = false;
    _startScore = appService.getCurrentGolds();    
    _endScore = _startScore + _stepCoins;  
    appService.dailyGolds.value-= _stepCoins;
    _isMultiCoins.value = false;    
    if(tapDownDetails!=null){
      _startPos = Offset(tapDownDetails.globalPosition.dx, tapDownDetails.globalPosition.dy);
    } else if(longPressEndDetails!=null) {
      _startPos = Offset(longPressEndDetails.globalPosition.dx, longPressEndDetails.globalPosition.dy);
      isLongPress = true;
    }
    
    _coinList.add(_singleColin(_startPos, isLongPress: isLongPress)); 
    setState(() {});    
  }

  void _startMultiSingleAnim(List<TapDownDetails> tapDetails) {    
    appService.vibrate();
    for(int i=0;i<tapDetails.length;i++){
      TapDownDetails details=tapDetails[i];
      _startSingleAnim(tapDownDetails: details, isVibration: false);
    }
  }

  void _startIncreaseCoins() {
    for(int i=0;i<60;i++){
      _coinList.add(_randomSigleCoin());
    }    
    _startScore = appService.mineInfoModel.value?.gold??0;    
    _endScore = _startScore + appService.morseCodeGolds.value;
    appService.mineInfoModel.value?.gold = _endScore;
    _isMultiCoins.value = true;
    setState(() {});    
    Future.delayed(const Duration(milliseconds: 300), (){
      _coinsController.forward();
      _coinsController.repeat().timeout(Duration(milliseconds:  duration * 3), onTimeout:  () {
        _coinsController.forward(from: 0);
        _coinsController.stop(canceled: true);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _coinsController = AnimationController(duration: Duration(milliseconds: duration), vsync: this);
    _isFirstLoad = appService.firstLoad['exchange']??true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appService.firstLoad['exchange']=false;
    });
    appService.dailyGolds.value = appService.mineInfoModel.value?.dailyGoldsLimit??0;
    _stepCoins = appService.mineInfoModel.value?.level??1;
  }

  @override
  void dispose() {
    _coinsController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPopInvoked(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Obx(()=>SingleChildScrollView(
          child: Stack(
            children: [
              Container(height: MediaQuery.of(context).size.height),
              AppPositionedBackground(assetPath: 'mine/gradient1.png', top: -80, left: 0, height: 400),
              AppPositionedBackground(assetPath: 'mine/back1.png', top: 90, left: 0, height: Get.height+300),                      
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(40.h),                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              constraints: BoxConstraints(minWidth: 100.w, maxWidth: 150.w),
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                                // border: Border.all(color: Colors.transparent, width: 2),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFfa3a01), Color(0xFFffac45),],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      checkIncreasedGolds();
                                      mainController.selectedPath.value=profilePath;
                                    },
                                    child: Container(
                                      width: 40.w,
                                      padding: EdgeInsets.all(1.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                                        color: AppColors.avatarBackground,
                                        border: const Border(right: BorderSide(color: Colors.black, width: 2))
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.w),
                                        child: appService.mineInfoModel.value!=null ?
                                          AppImage.asset('avatar/${appService.mineInfoModel.value?.avatar??0}.jpg',
                                          height: 40.h) : Container()
                                      )
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      checkIncreasedGolds();
                                      mainController.selectedPath.value=settingsPath;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(appService.getTrans("Settings"), 
                                            style: TextStyle(color: AppColors.fontPrimary, fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                          Gap(5.w),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 2.h),
                                            child: Icon(Icons.settings, color: AppColors.fontPrimary, size: 30.w)//AppImage.asset('mine/avatar5.png'),
                                          )
                                        ]
                                      ),
                                    )
                                  )
                                ],
                              ) 
                            ),                                                  
                            Gap(5.w),
                            Text(appService.mineInfoModel.value?.userName??"", style: TextStyle(color: AppColors.fontPrimary, 
                              fontWeight: FontWeight.w700, fontSize: 16.sp)
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: _showPopup,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.w),
                              color: AppColors.secondary
                            ),
                            child: Row(
                              children: [
                                Icon(AppIcons.key, color: AppColors.iconColor, size: 20.w,),
                                Gap(3.w),
                                Text("100", style:TextStyle(color: AppColors.fontPrimary, fontFamily: "SFUIText", fontSize: 12.sp, fontWeight: FontWeight.bold)),
                                Gap(3.w),
                                Icon(AppIcons.chevron_right, color: AppColors.fontSecondary, size: 10.w,),
                              ],
                            )
                          )
                        )
                      ]
                    ),
                    Gap(10.h),                     
                    SizedBox(          
                      width: 300.w,
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(appService.getTrans('Level'), style: TextStyle(color: AppColors.fontPrimary, 
                                      fontWeight: FontWeight.w700, fontSize: 12.sp)
                                    ),
                                    Icon(AppIcons.chevron_right, color: AppColors.fontSecondary, size: 10.w)
                                  ],
                                ),
                                Gap(30.w),
                                Row(
                                  children: [
                                    Text("${appService.mineInfoModel.value?.level??1}", style: TextStyle(color: AppColors.fontPrimary, fontFamily: "SFUIText", fontWeight: FontWeight.w700, fontSize: 12.sp)),
                                    Text(" / ${appService.mineInfoModel.value?.maxLevel??11}", style: TextStyle(color: AppColors.fontSecondary, fontFamily: "SFUIText", fontSize: 12.sp, fontWeight: FontWeight.bold))
                                  ],
                                )
                              ]
                            ),
                          ), 
                          Gap(5.h,),
                          FAProgressBar(
                            currentValue: appService.getLevelPercent(),
                            backgroundColor: AppColors.secondary,
                            border: Border.all(color: AppColors.fontSecondary, width: 1.h),
                            borderRadius: BorderRadius.circular(10.w),
                            progressGradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [Color(0xfff7f7cf), Color(0xffeae3a6), Color(0xff81b2e1), Color(0xffb881d9),],
                            ),
                            size: 17.h
                          ),
                        ],
                      )
                    ),            
                    Column(
                      children: [
                        Gap(10.h),
                        FirstAnimatorWidget(
                          incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                            curve: Curves.elasticInOut,                          
                            duration: const Duration(milliseconds: 500),
                          ),
                          isAnimate: _isFirstLoad,
                          child: GridView.count(
                            primary: false,
                            shrinkWrap: true,
                            crossAxisCount:4,
                            mainAxisSpacing: 10.w,
                            crossAxisSpacing: 10.w,
                            children: [
                              DailyItemButtonWidget(icon: 'mine/daily_reward.png', label: "Daily reward", 
                                onPressed: (){
                                  checkIncreasedGolds();
                                  mainController.selectedPath.value=earnMorePath;
                                }
                              ),
                              DailyItemButtonWidget(icon: 'mine/daily_cipher.png', label: "Daily cipher", 
                                onPressed: (){
                                  checkIncreasedGolds();
                                  if(appService.morseCodeGolds.value==-1) {
                                    AppToast.showToast(appService.getTrans("Already Participated!"));
                                  } else {
                                    controller.isCipher.value=!controller.isCipher.value;
                                    _morseCodes=[];
                                    controller.clearCode();
                                  }
                                }
                              ),
                              DailyItemButtonWidget(icon: 'mine/exchange.png', label: "Exchange", 
                                onPressed: (){
                                  checkIncreasedGolds();
                                  mainController.selectedPath.value=exchangePath;
                                }
                              ),
                              DailyItemButtonWidget(icon: 'mine/minigame.png', label: "Mini Game",  
                                onPressed: (){
                                  checkIncreasedGolds();
                                }
                              ),
                            ],
                          ),
                        ),
                        Gap(25.h),   
                        if(_isLoading.value && _isFirstLoad)
                        // ************ Coins on loading **********
                        FirstAnimatorWidget(
                          incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                            curve: Curves.elasticInOut,                          
                            duration: const Duration(milliseconds: 300),
                          ),
                          isAnimate: _isFirstLoad,
                          onIncomingAnimationComplete: (_){
                            _isLoading.value=false;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [                            
                              Container(
                                key: mainCoinKey,
                                child: AppImage.asset('mine/coin.png', width: 70.w).animate(                        
                                  autoPlay: false,
                                  controller: _coinsController
                                ).scale(delay: 100.ms, end: const Offset(1.2, 1.2), duration: 100.ms, curve: Curves.easeOut),
                              ),
                              Gap(5.w),                            
                              Countup(
                                begin: _startScore.toDouble(),
                                end: _endScore.toDouble(),
                                duration: const Duration(milliseconds: 100),
                                separator: ',',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight : FontWeight.w700,
                                  fontFamily: "SFUIText",
                                  color: Colors.white
                                ), 
                              ),
                            ],
                          ),    
                        ), 
                        if(!_isLoading.value || !_isFirstLoad)
                        // *********** Coins ***********
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [                            
                            Container(
                              key: mainCoinKey,
                              child: AppImage.asset('mine/coin.png', width: 70.w).animate(                        
                                autoPlay: false,
                                controller: _coinsController
                              ).scale(delay: 100.ms, end: const Offset(1.2, 1.2), duration: 100.ms, curve: Curves.easeOut),
                            ),
                            Gap(5.w),                          
                            Visibility(
                              visible: !_isMultiCoins.value,
                              child: Countup(
                                begin: _startScore.toDouble(),
                                end: _endScore.toDouble(),
                                duration: const Duration(milliseconds: 100),
                                separator: ',',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight : FontWeight.w700,
                                  fontFamily: "SFUIText",
                                  color: Colors.white
                                ), 
                              ),
                            ),
                            Visibility(
                              visible: _isMultiCoins.value,
                              child: Countup(
                                begin: _startScore.toDouble(),
                                end: _endScore.toDouble(),
                                duration: const Duration(seconds: 1),
                                separator: ',',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight : FontWeight.w700,
                                  fontFamily: "SFUIText",
                                  color: Colors.white
                                ), 
                              )
                            ).animate( 
                              autoPlay: false,
                              controller: _coinsController
                            ).scale(delay: 100.ms, end: const Offset(1.2, 1.2), duration: 100.ms, curve: Curves.easeOut),
                          ],
                        ),
                        // *********** End Coins ***********
                        //************ Main board on loading *************/                                                
                        Gap(25.h),
                        if(_isLoading.value && _isFirstLoad)
                        FirstAnimatorWidget(
                          incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                            curve: Curves.elasticInOut,                          
                            duration: const Duration(milliseconds: 300),
                          ),
                          isAnimate: _isFirstLoad,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:[
                              CoreButton(
                                onTapUp: (_) {},
                                onMultiTapUp: (_){},
                                onLongPressEnd: (_){},
                                child: AppImage.asset("skin/${appService.getSkinById(appService.mineInfoModel.value?.level??1).icon}", width: 170.w),
                              ),                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    AppImage.asset("mine/energy.png", width: 50.w),
                                    Gap(10.w),
                                    Text("${appService.getDialyGolds()} / ${appService.mineInfoModel.value?.dailyGoldsLimit??0}", 
                                      style: TextStyle(color: AppColors.fontPrimary, fontFamily: "SFUIText", fontWeight: FontWeight.bold, fontSize: 20.sp))
                                  ],),
                                  Row(children: [
                                    AppImage.asset("mine/boost.png", width: 50.w),
                                    Gap(10.w),
                                    Text(appService.getTrans("Boost"), style: TextStyle(color: AppColors.fontPrimary, 
                                      fontWeight: FontWeight.w700, fontSize: 20.sp))
                                  ],)
                                ],
                              )          
                            ]
                          )
                        ),
                        //),
                        //************** End Main board on loading *****************/
                        //************ Main board *************/
                        if(!_isLoading.value || !_isFirstLoad)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:[
                            if(controller.isCipher.value) 
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              margin: EdgeInsets.only(bottom: 20.h),
                              height: 60.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: AppColors.secondary
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(appService.getTrans("Daily cipher"), style:TextStyle(color: AppColors.fontPrimary, 
                                    fontSize: 16.sp, fontWeight: FontWeight.w700)
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: _morseCodes,
                                    )
                                  ),                                
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.w),
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF6060ff), Color(0xFFb25aff),],
                                        begin: FractionalOffset(0.0, 0.0),
                                        end: FractionalOffset(1.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp
                                      ),                                      
                                    ),
                                    child: Row(                                
                                      children: [
                                        AppImage.asset("mine/coin.png", width: 25.w),
                                        Gap(5.w),
                                        Text("+${AppUtils.intToStrWithComma(appService.morseCodeGolds.value)}", style: TextStyle(color: AppColors.fontPrimary, 
                                          fontSize: 16.sp, fontFamily: "SFUIText", fontWeight: FontWeight.w700)
                                        )
                                      ],
                                    )
                                  ),
                                ]
                              ),
                            ),
                            CoreButton(                              
                              onTapUp: (TapDownDetails details) => _startSingleAnim(tapDownDetails: details),
                              onMultiTapUp: (List<TapDownDetails> tapDetails) => _startMultiSingleAnim(tapDetails),
                              onLongPressEnd: (LongPressEndDetails details){
                                if(controller.isCipher.value){
                                  _startSingleAnim(longPressEndDetails: details);
                                }
                              },
                              child: AppImage.asset("skin/${appService.getSkinById(appService.mineInfoModel.value?.level??1).icon}", width: 170.w), 
                            ),
                            Gap(20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  AppImage.asset("mine/energy.png", width: 50.w),
                                  Gap(10.w),
                                  Text("${appService.dailyGolds} / ${appService.mineInfoModel.value?.dailyGoldsLimit}", 
                                    style: TextStyle(color: AppColors.fontPrimary, fontFamily: "SFUIText", fontWeight: FontWeight.bold, fontSize: 20.sp))
                                ],),
                                GestureDetector(
                                  onTap: (){
                                    checkIncreasedGolds();
                                    mainController.selectedPath.value=balancePath;
                                  },
                                  child: Row(children: [
                                    AppImage.asset("mine/boost.png", width: 50.w),
                                    Gap(10.w),
                                    Text(appService.getTrans("Boost"), style: TextStyle(color: AppColors.fontPrimary, 
                                      fontWeight: FontWeight.w700, fontSize: 20.sp))
                                  ],)
                                )
                              ],
                            )          
                          ]
                        )
                        //************** End Main board *****************/
                      ],
                    )
                  ],
                )            
              ),          
              ..._coinList, 
              if(_isCrackedMorseCode.value)
              CodeCrackedWidget(onPressed: (){
                _isCrackedMorseCode.value=false;                
                _startIncreaseCoins();
                controller.clearCode();
              },)
            ],
          )
        ))
      )
    );
  }

  Widget _singleColin(Offset offset, {bool isLongPress=false}) {
    return Positioned(
      top: 0, left: 0,
      child: _animateNumber(isLongPress)
        .animate(
          autoPlay: true,
          onComplete: (_) {
            appService.increasedGolds.value += _stepCoins;
            appService.dailyGolds.value += _stepCoins;    
            if(controller.isCipher.value) {
              String code = isLongPress?"1":"0";
              String? letter = controller.checkMorseCode(code);
              if(letter!=null) {
                if(letter!="") {
                  enterMorseCode(letter);
                }
              } else {
                setState(() {_morseCodes=[];});
              }
            }
          }
        ).move(
          begin: offset, 
          end: Offset(offset.dx, offset.dy-150), 
          delay: 1.ms, 
          duration: 500.ms
        )        
        .fadeOut(delay: 200.ms)
        .hide()                    
    );   
  } 

  Widget _animateNumber(bool isLongPress){
    if(!controller.isCipher.value){
      return Text("+$_stepCoins", 
        style: TextStyle(color: Colors.white, fontSize: 33.sp, fontFamily: "SFUIText", fontWeight: FontWeight.w700)
      );
    } else {
      if(!isLongPress) {
        return Container(
          width: 25.w, height: 25.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.w)),
            color: AppColors.fontSecondary
          ),
        );
      } else {
        return Container(
          width: 30.w, height: 10.h,
          decoration: const BoxDecoration(
            color: AppColors.fontSecondary
          ),
        );
      }
    }
  }

  Widget _randomSigleCoin() {
    RenderBox box = mainCoinKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position    

    final random = math.Random();
    double x = random.nextInt(MediaQuery.of(context).size.width.toInt()).toDouble();
    double x2 = position.dx, y2 = position.dy;
    double y = MediaQuery.of(context).size.height - 50 + random.nextInt(50);
    int duration = 300 + random.nextInt(500);
    int delay = 1 + random.nextInt(200);
    return Positioned(
      top: 0, left: 0,
      child: AppImage.asset('mine/coin.png', width: 50.w).animate(        
        autoPlay: true,
      ).move(
        begin: Offset(x, y), 
        end: Offset(x2, y2), 
        delay: delay.ms, 
        duration: duration.ms
      )
      // .scaleXY(delay: 100.ms, end: 0.5, curve: Curves.easeIn) 
      .fadeOut(delay: 200.ms).hide()
    );   
  }

  Future<void> _showPopup() async {
    checkIncreasedGolds();
    final result = await showPopupCard<String>(
      context: context,
      builder: (context) {
        return PopupCard(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.w),
            side: BorderSide(
              color: AppColors.secondary,
              width: 2.w
            ),
          ),
          color: AppColors.primary,
          child: CodePopupWidget()
        );
      },
      offset: const Offset(-8, 50),
      alignment: Alignment.topRight,
      useSafeArea: true,
    );
    if (result == null) return;
    // setState(() {
    //   message = result;
    // });
  }

  void enterMorseCode(String code) {    
    Widget widget = Text(code, style:TextStyle(color: AppColors.fontPrimary, 
      fontSize: 18.sp, fontWeight: FontWeight.w700), textAlign: TextAlign.center,
    )
    .animate(
      autoPlay: true,
      onComplete: (_) async {
        if(controller.checkMorseLetters()) {
          await controller.morseVerify();
          if(appService.morseCodeGolds.value==-1) {
            controller.isCipher.value=false;
            AppToast.showToast(appService.getTrans("Already Participated!"));
          } else {
            _isCrackedMorseCode.value=true;
          }
          
        }
      }
    )
    .scale(begin: const Offset(4, 4), end: const Offset(1, 1), duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    
    setState(() {
      _morseCodes.add(widget);
    });
  }

  Future<void> checkIncreasedGolds() async {
    if(appService.increasedGolds.value>0) {
      controller.addGold();
    }
  }

  Future<bool> _onPopInvoked() async {
    await checkIncreasedGolds();
    return (await showDialog(
      context: context,
      builder: (context) => AppCommonDialog(
        okLabel: appService.getTrans("Yes"),
        cancelLabel: appService.getTrans("No"),
        msg: appService.getTrans("Are you sure to want to exit an App?"),
        title: appService.getTrans("Confirm"),
        onOk:(){          
          Navigator.of(context).pop(true);
        },
        onCancel: ()=>Navigator.of(context).pop(false),
      )
    ));    
  }
}