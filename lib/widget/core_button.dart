import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/pages/mine/mine_view_controller.dart';
import 'package:kombat_flutter/pages/mine/widget/multi_touch_gesture_recognizer.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class CoreButton extends StatefulWidget {
  final Widget child;
  final void Function(TapDownDetails) onTapUp;
  final void Function(List<TapDownDetails>) onMultiTapUp;
  final void Function(LongPressEndDetails) onLongPressEnd;

  const CoreButton({
    super.key, 
    required this.child, 
    required this.onTapUp, 
    required this.onMultiTapUp, 
    required this.onLongPressEnd
  });

  @override
  // ignore: library_private_types_in_public_api
  _CoreButtonState createState() => _CoreButtonState();
}

class _CoreButtonState extends State<CoreButton>
    with SingleTickerProviderStateMixin {
  
  AppService appService = Get.find<AppService>();
  MineViewController controller = Get.find<MineViewController>();
  static const clickAnimationDurationMillis = 100;

  double _skewX=0, _skewY=0;
  double _sX=1, _sY=1;
  GlobalKey mainKey = GlobalKey();
  final RxBool _showFlash = false.obs;

  // needed for the "click" tap effect
  late final AnimationController animationController;
  bool isLongPressed = false;
  int tapMode = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
      setState(() {        
        _skewX = _sX*animationController.value;
        _skewY = _sY*animationController.value;
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    _showFlash.value=false;
    super.dispose();
  }

  void _shrinkButtonSize() {
    animationController.forward();
    _showFlash.value = true;
  }

  void _restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
      () {
        animationController.reverse();
        _showFlash.value=false;
      }
    );
  }

  void _realTap(int pointer) {    
    _shrinkButtonSize();
    _restoreButtonSize();
  }

  void _realTapUp(int pointer, TapDownDetails details) {
    if(!isLongPressed) {
      widget.onTapUp.call(details);
      tapMode = 0;
    }
    Offset pos = Offset(details.globalPosition.dx, details.globalPosition.dy);
    _getPositions(pos);
    _shrinkButtonSize();
  }

  void _getPositions(Offset pos){
    RenderBox box = mainKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    Offset center = Offset(box.size.width/2, box.size.height/2);
    _sX = (center.dx-pos.dx)*0.6/(box.size.width/2);
    _sY = (center.dy+position.dy-pos.dy)*0.6/(box.size.height/2);
  }

  void _realTapCancel(int pointer) {
    _restoreButtonSize();
  }

  void _multiTapUp(List<TapDownDetails> details) {
    if(tapMode==1) {
      _realTapUp(1, details[details.length-1]);
    } else {
      widget.onMultiTapUp.call(details);
      tapMode = 2;
    }
    
  }

  @override
  Widget build(BuildContext context) {    
    return RawGestureDetector(
      gestures: {
        MultiTouchGestureRecognizer: GestureRecognizerFactoryWithHandlers<
            MultiTouchGestureRecognizer>(
          () => MultiTouchGestureRecognizer(_multiTapUp, _realTap, _realTapUp, _realTapCancel),
          (MultiTouchGestureRecognizer instance) {
            instance.minNumberOfTouches = 5;            
          },
        ),
      },
      key: mainKey,
    // GestureDetector(
      // key: mainKey,
      // onTap: () {
      //   // widget.onTap?.call();
      //   _shrinkButtonSize();
      //   _restoreButtonSize();
      // },
      // onTapDown: (TapDownDetails details) {
      //   widget.onTapDown?.call(details);
      //   Offset pos = Offset(details.globalPosition.dx, details.globalPosition.dy);
      //   RenderBox box = mainKey.currentContext?.findRenderObject() as RenderBox;
      //   Offset position = box.localToGlobal(Offset.zero);
      //   Offset center = Offset(box.size.width/2, box.size.height/2);
      //   _sX = (center.dx-pos.dx)*0.6/(box.size.width/2);
      //   _sY = (center.dy+position.dy-pos.dy)*0.6/(box.size.height/2);        
      //   _shrinkButtonSize();
      // },
      // onTapCancel: _restoreButtonSize,
      // child: Transform.scale(
      //   scale: _scaleTransformValue,
      //   child: Container(
      //     alignment: Alignment.center,
      //     child: widget.child,           
      //   ),
      // ),
      child: GestureDetector(
        onLongPressEnd: (LongPressEndDetails details){
          isLongPressed = true;
          widget.onLongPressEnd.call(details);
          tapMode = 1;
          Offset pos = Offset(details.globalPosition.dx, details.globalPosition.dy);
          _getPositions(pos);          
          _realTap(0);
          isLongPressed = false;
        },
        child: Obx(()=>Transform(
          transform: Matrix4.skew(_skewX, _skewY),
          alignment: FractionalOffset.center,
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if(!controller.isCipher.value)
                AppImage.asset('mine/frame.png'),
                if(controller.isCipher.value)
                AppImage.asset('mine/frame_cipher.png'),
                Visibility(
                  visible: _showFlash.value,
                  child: Container(
                    height: 130.h, width: 50.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 10,
                          blurRadius: 40,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]
                    ),
                  )
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: widget.child
                  )
                )
              ],
            )
          )
        ))
      )
    );
  }
}