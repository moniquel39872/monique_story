import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

@immutable
// ignore: must_be_immutable
class FirstAnimatorWidget extends StatefulWidget {
  FirstAnimatorWidget({
    super.key, 
    this.onIncomingAnimationComplete,
    required this.incomingEffect, 
    required this.isAnimate, 
    required this.child
  });
  
  bool isAnimate;
  WidgetTransitionEffects? incomingEffect;
  dynamic Function(Key?)? onIncomingAnimationComplete;
  Widget child;

  @override
  // ignore: library_private_types_in_public_api
  _FirstAnimatorWidgetState createState() => _FirstAnimatorWidgetState();
}

class _FirstAnimatorWidgetState extends State<FirstAnimatorWidget> {
  
  @override
  Widget build(BuildContext context) {
    if(!widget.isAnimate) {
      return widget.child;
    } else {
      return WidgetAnimator(
        incomingEffect: widget.incomingEffect,
        onIncomingAnimationComplete: widget.onIncomingAnimationComplete,
        child: widget.child,
      );
    }
  }
}