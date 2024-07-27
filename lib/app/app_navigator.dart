import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class AppNavigator {
  static toNamed(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    bool? checkLogin = false,
  }) {
    Get.toNamed(page,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }

  static offAndToNamed(
    String page, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    Get.offAndToNamed(page,
        arguments: arguments, id: id, parameters: parameters);
  }

  static offAllNamed(
    String page, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    Get.offAllNamed(page, arguments: arguments, id: id, parameters: parameters);
  }

  static back<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Get.back(
        result: result, closeOverlays: closeOverlays, canPop: canPop, id: id);
  }

  static dialog<T>(
    Widget widget, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    Get.dialog(widget,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        useSafeArea: useSafeArea,
        navigatorKey: navigatorKey,
        arguments: arguments,
        transitionDuration: transitionDuration,
        transitionCurve: transitionCurve,
        name: name,
        routeSettings: routeSettings);
  }

  static bottomSheet<T>(
    Widget bottomsheet, {
    Color? backgroundColor,
    double? elevation,
    bool persistent = true,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool? ignoreSafeArea,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? settings,
    Duration? enterBottomSheetDuration,
    Duration? exitBottomSheetDuration,
    bool? checkLogin = false,
  }) {
    

    // Get.bottomSheet(
    //   BaseBottomSheet(
    //     child: bottomsheet,
    //   ),
    //   backgroundColor: backgroundColor,
    //   elevation: elevation,
    //   persistent: persistent,
    //   shape: shape,
    //   clipBehavior: clipBehavior,
    //   barrierColor: barrierColor,
    //   ignoreSafeArea: ignoreSafeArea,
    //   isScrollControlled: isScrollControlled,
    //   useRootNavigator: useRootNavigator,
    //   isDismissible: isDismissible,
    //   enableDrag: enableDrag,
    //   settings: settings,
    //   enterBottomSheetDuration: enterBottomSheetDuration,
    //   exitBottomSheetDuration: exitBottomSheetDuration,
    // );
  }
}
