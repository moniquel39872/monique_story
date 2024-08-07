import "package:flutter/gestures.dart";

class MultiTouchGestureRecognizer extends MultiTapGestureRecognizer {
  MultiTouchGestureRecognizerCallback onMultiTap;  
  TapRecognizerCallback onRealTap;
  TapDownRecognizerCallback onRealTapUp;  
  TapCancelRecognizerCallback onRealTapCancel;  
  var numberOfTouches = 0;
  int minNumberOfTouches = 0;
  List<TapDownDetails> tapDetails = [];

  MultiTouchGestureRecognizer(this.onMultiTap, this.onRealTap, this.onRealTapUp, this.onRealTapCancel) {
    super.onTapDown = (pointer, details) => addTouch(pointer, details);
    super.onTapUp = (pointer, details) => removeTouch(pointer, details);
    super.onTapCancel = (pointer) => cancelTouch(pointer);
    super.onTap = (pointer) => onRealTap(pointer);   
  }

  void addTouch(int pointer, TapDownDetails details) {
    tapDetails.add(details);        
    numberOfTouches++;         
  }

  void removeTouch(int pointer, TapUpDetails details) {
    if (numberOfTouches>1 && numberOfTouches <= minNumberOfTouches) {
      onMultiTap(tapDetails);
    } else if(numberOfTouches==1){
      onRealTapUp(pointer, tapDetails[0]);
    }
    numberOfTouches = 0;
    tapDetails = [];
  }

  void cancelTouch(int pointer) {
    numberOfTouches = 0;
    tapDetails = [];
    onRealTapCancel(pointer);
  }
  
  @override
  set onTapDown(_onTapDown) {}

  @override
  set onTapUp(_onTapUp) {}

  @override
  set onTapCancel(_onTapCancel) {}

  @override
  set onTap(_onTap) {}
}

typedef MultiTouchGestureRecognizerCallback = void Function(List<TapDownDetails> tapDetails);
typedef TapRecognizerCallback = void Function(int pointer);
typedef TapDownRecognizerCallback = void Function(int pointer, TapDownDetails details);
typedef TapCancelRecognizerCallback = void Function(int pointer);