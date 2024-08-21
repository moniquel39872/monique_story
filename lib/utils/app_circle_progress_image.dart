// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kombat_flutter/theme/app_colors.dart';
import 'dart:math';

import 'package:kombat_flutter/utils/app_circle_progress.dart';
import 'package:kombat_flutter/utils/app_image.dart';

// ignore: must_be_immutable
class AppCircularProgressIndicatorWithImage extends StatefulWidget {
  int value = 0;
  int? duration = 0;
  int? loadingDuration = 0;
  AppCircularProgressIndicatorWithImage(
      {super.key,
      required this.value,
      this.duration,
      this.loadingDuration = 10});

  @override
  _AppCircularProgressIndicatorWithImageState createState() =>
      _AppCircularProgressIndicatorWithImageState();
}

class _AppCircularProgressIndicatorWithImageState
    extends State<AppCircularProgressIndicatorWithImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void didUpdateWidget(
      covariant AppCircularProgressIndicatorWithImage oldWidget) {
    if (widget.value != oldWidget.value) {
      if (widget.duration! > 0) {
        _controller = AnimationController(
          duration: Duration(seconds: widget.duration!),
          vsync: this,
        );
      }
      _animation = Tween<double>(begin: widget.value.toDouble(), end: 100)
          .animate(_controller)
        ..addListener(() {
          if (_animation.value >= 99) {
            _controller.stop();
          }
          setState(() {});
        });
      _controller.forward();
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: widget.loadingDuration!),
      vsync: this,
    );

    _animation = Tween<double>(begin: widget.value.toDouble(), end: 100)
        .animate(_controller)
      ..addListener(() {
        if (_animation.value >= 99) {
          _controller.stop();
        }
        setState(() {});
      });

    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double progress = _animation.value;
        double angle = 2 * pi * (progress / 100);
        double radius = 80.w; // Radius of the circular progress
        Offset center = Offset(radius, radius);
        Offset textOffset = Offset(
          center.dx + (radius) * cos(angle - pi / 2),
          center.dy + (radius) * sin(angle - pi / 2),
        );

        return SizedBox(
            width: 200.w,
            height: 200.w,
            child: Stack(children: [
              Container(
                  padding: EdgeInsets.all(25.w),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: Size(radius * 2, radius * 2),
                        painter: AppCircularProgressPainter(
                          progress: progress,
                          backgroundColor: Colors.transparent,
                          progressColor: AppColors.fontMenu2,
                        ),
                        child: Center(
                            child: Container(
                          margin: EdgeInsets.all(15.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.w),
                              shape: BoxShape.circle),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.fontMenu2,
                                      width: 15.w),
                                  shape: BoxShape.circle),
                              child: AppImage.asset('mine/coin.png',
                                  width: 50.w)),
                        )),
                      ),
                    ],
                  )),
              Positioned(
                left: textOffset.dx,
                top: textOffset.dy + 8.w,
                child: Transform.rotate(
                  angle: angle,
                  child: Text(
                    '${progress.toInt()}%',
                    style: TextStyle(
                      fontSize: 22.w,
                      color: AppColors.fontMenu2,
                    ),
                  ),
                ),
              ),
            ]));
      },
    );
  }
}
