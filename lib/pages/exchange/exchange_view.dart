import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_popup_card/flutter_popup_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_routes.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/pages/exchange/widget/code_popup_widget.dart';
import 'package:kombat_flutter/pages/exchange/widget/daily_item_button_widget.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'package:kombat_flutter/utils/app_icons.dart';
import 'package:kombat_flutter/utils/app_image.dart';
import 'package:kombat_flutter/widget/app_positioned_background.dart';
import 'dart:math' as math;

import 'package:kombat_flutter/widget/core_button.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> with TickerProviderStateMixin  {
  MainController mainController = Get.find();
  late final AnimationController _coinsController;  
  Offset _startPos = Offset(100.w, 100.w);
  final List<Widget> _coinList = [];  
  final int _stepCoins = 2;
  final int _stepMultiCoins = 120;
  int duration = 200;
  GlobalKey mainCoinKey = GlobalKey();
  late int _startScore = 0, _endScore = mainController.scores;
  final RxBool _isMultiCoins = false.obs;  
  final RxBool _isLoading = true.obs;

  void _startSingleAnim(TapDownDetails details) {
    _startScore = mainController.scores;
    mainController.scores += _stepCoins;
    _endScore = mainController.scores;    
    _isMultiCoins.value = false;    
    _startPos = Offset(details.globalPosition.dx, details.globalPosition.dy);
    _coinList.add(_singleColin(_startPos)); 
    setState(() {});    
  }

  void _startIncreaseCoins() {
    for(int i=0;i<60;i++){
      _coinList.add(_randomSigleCoin());
    }    
    _startScore = mainController.scores;
    mainController.scores += _stepMultiCoins;
    _endScore = mainController.scores;
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
  }

  @override
  void dispose() {
    _coinsController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppPositionedBackground(assetPath: 'gradient1.png', top: -80, left: 0, height: 400),
          AppPositionedBackground(assetPath: 'back1.png', top: 90, left: 0, height: Get.height+300),          
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap:()=> mainController.selectedPath.value=profilePath,
                          child: Container(
                            width: 100.w, height: 40.h,                          
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
                              children: [
                                Container(
                                  width: 40.h,
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.w)),
                                    color: AppColors.avatarBackground,
                                    border: const Border(right: BorderSide(color: Colors.black, width: 2))
                                  ),
                                  child: AppImage.asset('avatar5.png')
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Buy\nskin", style: TextStyle(color: AppColors.fontPrimary, fontSize: 11.sp)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.h),
                                        child: AppImage.asset('avatar5.png'),
                                      )
                                    ]
                                  ),
                                )
                              ],
                            ) 
                          ),
                        ),                        
                        SizedBox(width: 5.w),
                        Text("Dirk Ackerman(CEO)", style: TextStyle(color: AppColors.fontPrimary, 
                          fontWeight: FontWeight.bold, fontSize: 16.sp)
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
                            SizedBox(width: 3.w),
                            Text("100", style:TextStyle(color: AppColors.fontPrimary, fontSize: 12.sp)),
                            SizedBox(width: 3.w),
                            Icon(AppIcons.chevron_right, color: AppColors.fontSecondary, size: 10.w,),
                          ],
                        )
                      )
                    )                    
                  ]
                ),
                SizedBox(height: 5.h),                
                Row(
                  children: [
                    SizedBox(                      
                      width: 170.w,
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('Bronze', style: TextStyle(color: AppColors.fontPrimary, 
                                      fontWeight: FontWeight.bold, fontSize: 12.sp)
                                    ),
                                    Icon(AppIcons.chevron_right, color: AppColors.fontSecondary, size: 10.w)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("1", style: TextStyle(color: AppColors.fontPrimary, fontWeight: FontWeight.bold, fontSize: 12.sp)),
                                    Text("/11", style: TextStyle(color: AppColors.fontSecondary, fontSize: 12.sp))
                                  ],
                                )
                              ]
                            ),
                          ), 
                          SizedBox(height: 5.h,),
                          Container(                            
                            height: 10.h, width: 170.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.h),
                              color: const Color(0xFF49412d),
                              border: Border.all(color: AppColors.borderColor, width: 1.w),                              
                            ),
                            // child: Container(
                            //   height: 8.h, width: 10.w,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(15.h),
                            //     gradient: const LinearGradient(
                            //       colors: [Color(0xFF6060ff), Color(0xFFb25aff),],
                            //       begin: FractionalOffset(0.0, 0.0),
                            //       end: FractionalOffset(1.0, 0.0),
                            //       stops: [0.0, 1.0],
                            //       tileMode: TileMode.clamp
                            //     ), 
                            //     border: Border.all(color: AppColors.borderColor, width: 1.w),                              
                            //   ),
                            // )
                          )
                        ],
                      )
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: Container(
                        height: 50.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.w),
                          border: Border.all(color: AppColors.borderColor, width: 2.w),
                          color: const Color(0xFF49412d)
                        ),
                        child: Row(                          
                          children: [
                            AppImage.asset('avatar0.png'),
                            SizedBox(width: 5.w),
                            VerticalDivider(color: AppColors.borderColor, thickness: 2.w, indent: 8.h, endIndent: 8.h,),
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Profit per hour", style: TextStyle(color: AppColors.fontMenu4, fontSize: 13.sp)),
                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppImage.asset('coin.png', width: 25.w),
                                    SizedBox(width: 5.w),
                                    Text("0", style: TextStyle(color: AppColors.fontPrimary, fontWeight: FontWeight.bold, fontSize: 16.sp)),
                                    SizedBox(width: 5.w),
                                    Icon(AppIcons.exclamation_circle, color: AppColors.borderColor, size: 18.w)
                                  ]
                                )
                              ],
                            )),
                            VerticalDivider(color: AppColors.borderColor, thickness: 2.w, indent: 8.h, endIndent: 8.h,),
                            SizedBox(width: 5.w),
                            GestureDetector(
                              onTap: ()=>mainController.selectedPath.value=settingsPath,
                              child: Icon(Icons.settings, color: AppColors.fontPrimary, size: 30.w)
                            )
                          ] 
                        )
                      )
                    )
                  ],
                ),                                
                Expanded(
                  child: Column(                    
                    children: [
                      SizedBox(height: 10.h),
                      WidgetAnimator(
                        incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(
                          curve: Curves.elasticInOut,                          
                          duration: const Duration(milliseconds: 500),
                        ),
                        child: GridView.count(
                          primary: false,
                          shrinkWrap: true,
                          crossAxisCount:4,
                          mainAxisSpacing: 10.w,
                          crossAxisSpacing: 10.w,
                          children: [
                            DailyItemButtonWidget(icon: 'daily1.png', label: "Daily reward", 
                              onPressed: ()=>mainController.selectedPath.value=earnPath),
                            DailyItemButtonWidget(icon: 'daily2.png', label: "Daily cipher", 
                              onPressed: ()=>mainController.isCipher.value=!mainController.isCipher.value),
                            DailyItemButtonWidget(icon: 'daily3.png', label: "Daily combo", 
                              onPressed: (){}),
                            DailyItemButtonWidget(icon: 'daily4.png', label: "Mini Game",  
                              onPressed: (){}),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h),   
                      if(_isLoading.value)
                      // ************ Coins on loading **********
                      WidgetAnimator(
                        incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                          curve: Curves.elasticInOut,                          
                          duration: const Duration(milliseconds: 300),
                        ),
                        onIncomingAnimationComplete: (_){
                          _isLoading.value=false;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [                            
                            Container(
                              key: mainCoinKey,
                              child: AppImage.asset('coin.png').animate(                        
                                autoPlay: false,
                                controller: _coinsController
                              ).scale(delay: 100.ms, end: const Offset(1.2, 1.2), duration: 100.ms, curve: Curves.easeOut),
                            ),
                            SizedBox(width: 5.w),                            
                            Countup(
                              begin: _startScore.toDouble(),
                              end: _endScore.toDouble(),
                              duration: const Duration(milliseconds: 100),
                              separator: ',',
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight : FontWeight.bold,
                                color: Colors.white
                              ), 
                            ),
                          ],
                        ),    
                      ), 
                      if(!_isLoading.value)
                      // *********** Coins ***********
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [                            
                          Container(
                            key: mainCoinKey,
                            child: AppImage.asset('coin.png').animate(                        
                              autoPlay: false,
                              controller: _coinsController
                            ).scale(delay: 100.ms, end: const Offset(1.2, 1.2), duration: 100.ms, curve: Curves.easeOut),
                          ),
                          SizedBox(width: 5.w),                          
                          Visibility(
                            visible: true,//!_isMultiCoins.value,
                            child: Countup(
                              begin: _startScore.toDouble(),
                              end: _endScore.toDouble(),
                              duration: const Duration(milliseconds: 100),
                              separator: ',',
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight : FontWeight.bold,
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
                                fontWeight : FontWeight.bold,
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
                      if(_isLoading.value)
                      Expanded(
                        child: WidgetAnimator(
                          incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                            curve: Curves.elasticInOut,                          
                            duration: const Duration(milliseconds: 300),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:[
                              CoreButton(
                                onTapDown: (_) {},
                                child: AppImage.asset('avatar_large.png'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    AppImage.asset("vector1.png"),
                                    SizedBox(width: 10.w),
                                    Text("1000 / 1000", style: TextStyle(color: AppColors.fontPrimary, 
                                      fontWeight: FontWeight.bold, fontSize: 20.sp))
                                  ],),
                                  Row(children: [
                                    AppImage.asset("boost.png"),
                                    SizedBox(width: 10.w),
                                    Text("Boost", style: TextStyle(color: AppColors.fontPrimary, 
                                      fontWeight: FontWeight.bold, fontSize: 20.sp))
                                  ],)
                                ],
                              )          
                            ]
                          )
                        )
                      ),
                      //************** End Main board on loading *****************/
                      //************ Main board *************/
                      if(!_isLoading.value)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:[
                            if(mainController.isCipher.value) 
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              height: 60.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: AppColors.secondary
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Daily cipher", style:TextStyle(color: AppColors.fontPrimary, 
                                    fontSize: 16.sp, fontWeight: FontWeight.bold)
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
                                        AppImage.asset("coin.png", width: 25.w),
                                        SizedBox(width: 5.w),
                                        Text("+1,000,000", style: TextStyle(color: AppColors.fontPrimary, 
                                          fontSize: 16.sp, fontWeight: FontWeight.bold)
                                        )
                                      ],
                                    )
                                  ),
                                ]
                              ),
                            ),
                            CoreButton(
                              onTapDown: (TapDownDetails details) => _startSingleAnim(details),
                              child: AppImage.asset('avatar_large.png'),
                            ),
                            if(!mainController.isCipher.value) 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  AppImage.asset("vector1.png"),
                                  SizedBox(width: 10.w),
                                  Text("1000 / 1000", style: TextStyle(color: AppColors.fontPrimary, 
                                    fontWeight: FontWeight.bold, fontSize: 20.sp))
                                ],),
                                GestureDetector(
                                  onTap: ()=>mainController.selectedPath.value=balancePath,
                                  child: Row(children: [
                                    AppImage.asset("boost.png"),
                                    SizedBox(width: 10.w),
                                    Text("Boost", style: TextStyle(color: AppColors.fontPrimary, 
                                      fontWeight: FontWeight.bold, fontSize: 20.sp))
                                  ],)
                                )
                              ],
                            )          
                          ]
                        )
                      ),
                      //************** End Main board *****************/
                    ],
                  )
                ),
              ],
            )            
          ),          
          ..._coinList, 
        ],
      )
    )
    );
  }

  Widget _singleColin(Offset offset) {
    if(!mainController.isCipher.value){
      return Positioned(
        top: 0, left: 0,
        child: Text("+$_stepCoins", 
            style: TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.bold))
          .animate(
            autoPlay: true,
          ).move(
            begin: offset, 
            end: Offset(offset.dx, offset.dy-150), 
            delay: 1.ms, 
            duration: 500.ms
          )
          .fadeOut(delay: 200.ms)        
          .hide()
      );   
    } else {
      return Positioned(
        top: 0, left: 0,
        child: Container(
            width: 25.w, height: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.w)),
              color: AppColors.fontSecondary
            ),
          )      
          .animate(
            autoPlay: true,
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
  } 

  Widget _randomSigleCoin() {
    RenderBox box = mainCoinKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position    

    final random = math.Random();
    double x = random.nextInt(MediaQuery.of(context).size.width.toInt()).toDouble();
    double x2 = position.dx+20.w/2, y2 = position.dy+20.h/2;
    double y = MediaQuery.of(context).size.height - 50 + random.nextInt(50);
    int duration = 300 + random.nextInt(500);
    int delay = 1 + random.nextInt(200);
    return Positioned(
      top: 0, left: 0,
      child: Image.asset('assets/images/icon_coin.png').animate(        
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
          child: const CodePopupWidget()
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
}