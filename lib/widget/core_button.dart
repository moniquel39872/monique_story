import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/pages/exchange/exchange_controller.dart';
import 'package:kombat_flutter/pages/exchange/widget/multi_touch_gesture_recognizer.dart';
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
  ExchangeController controller = Get.find<ExchangeController>();
  static const clickAnimationDurationMillis = 100;

  double _skewX=0, _skewY=0;
  double _sX=1, _sY=1;
  GlobalKey mainKey = GlobalKey();

  // needed for the "click" tap effect
  late final AnimationController animationController;

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
    super.dispose();
  }

  void _shrinkButtonSize() {
    animationController.forward();
  }

  void _restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
      () => animationController.reverse(),
    );
  }

  void _realTap(int pointer) {
    _shrinkButtonSize();
    _restoreButtonSize();
  }

  void _realTapUp(int pointer, TapDownDetails details) {
    widget.onTapUp.call(details);
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

  @override
  Widget build(BuildContext context) {    
    return RawGestureDetector(
      gestures: {
        MultiTouchGestureRecognizer: GestureRecognizerFactoryWithHandlers<
            MultiTouchGestureRecognizer>(
          () => MultiTouchGestureRecognizer(widget.onMultiTapUp, _realTap, _realTapUp, _realTapCancel),
          (MultiTouchGestureRecognizer instance) {
            instance.minNumberOfTouches = 3;            
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
          widget.onLongPressEnd.call(details);
          Offset pos = Offset(details.globalPosition.dx, details.globalPosition.dy);
          _getPositions(pos);          
          _realTap(0);
        },
        child: Obx(()=>Transform(
          transform: Matrix4.skew(_skewX, _skewY),
          alignment: FractionalOffset.center,
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                if(!controller.isCipher.value)
                AppImage.asset('frame.png'),
                if(controller.isCipher.value)
                AppImage.asset('frame3.png'),
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