import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/controllers/main_controller.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class CoreButton extends StatefulWidget {
  final Widget child;
  final void Function(TapDownDetails)? onTapDown;

  const CoreButton({super.key, required this.child, this.onTapDown});

  @override
  // ignore: library_private_types_in_public_api
  _CoreButtonState createState() => _CoreButtonState();
}

class _CoreButtonState extends State<CoreButton>
    with SingleTickerProviderStateMixin {
  
  MainController mainController = Get.find();
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

  @override
  Widget build(BuildContext context) {    
    return GestureDetector(
      key: mainKey,
      onTap: () {
        // widget.onTap?.call();
        _shrinkButtonSize();
        _restoreButtonSize();
      },
      onTapDown: (TapDownDetails details) {
        widget.onTapDown?.call(details);
        Offset pos = Offset(details.globalPosition.dx, details.globalPosition.dy);
        RenderBox box = mainKey.currentContext?.findRenderObject() as RenderBox;
        Offset position = box.localToGlobal(Offset.zero);
        Offset center = Offset(box.size.width/2, box.size.height/2);
        _sX = (center.dx-pos.dx)*0.6/(box.size.width/2);
        _sY = (center.dy+position.dy-pos.dy)*0.6/(box.size.height/2);        
        _shrinkButtonSize();
      },
      onTapCancel: _restoreButtonSize,
      // child: Transform.scale(
      //   scale: _scaleTransformValue,
      //   child: Container(
      //     alignment: Alignment.center,
      //     child: widget.child,           
      //   ),
      // ),
      child: Obx(()=>Transform(
        transform: Matrix4.skew(_skewX, _skewY),
        alignment: FractionalOffset.center,
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              if(!mainController.isCipher.value)
              AppImage.asset('frame.png'),
              if(mainController.isCipher.value)
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
    );
  }
}