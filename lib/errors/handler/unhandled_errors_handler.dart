import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_constant.dart';

void handleFlutterError(
  FlutterErrorDetails details,
  GlobalKey<NavigatorState> navigatorKey,
) {
  if (AppConstant.getRunEnvIsRelease()) {
    // Release 环境不弹窗，通过其他方式记录异常
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  } else {
    FlutterError.dumpErrorToConsole(details);

    var error = details.exception;
    if (error is DioException) {
      // 预处理后的网络异常，弹窗提示 debug 信息
      showUnhandledErrorDialog(
          debugText: error.message ?? error.response.toString());
    }
  }
}

void handleError(
    Object error, StackTrace stack, GlobalKey<NavigatorState> navigatorKey) {
  if (AppConstant.getRunEnvIsRelease()) {
    // Release环境不弹窗，通过其他方式记录异常
  } else {
    if (error is DioException) {
      // 预处理后的网络异常，弹窗提示
      showUnhandledErrorDialog(
          debugText:
              '${error.requestOptions.path}\n${error.message ?? error.response.toString()}');
    }
  }
}

Future<void>? _unknownErrorDialogFuture;

void showUnhandledErrorDialog({String? debugText}) async {
  // try {
  //   // Setting this future ensures only 1 dialog is ever shown at a time
  //   if (_unknownErrorDialogFuture == null) {
  //     _unknownErrorDialogFuture = showErrorDialog(
  //       errorDesc: 'Something went wrong.',
  //       errorTitle: 'oops',
  //       buttonText: 'ok',
  //       debugText: debugText,
  //     ).whenComplete(() => _unknownErrorDialogFuture = null);

  //     await _unknownErrorDialogFuture;
  //   }
  // } catch (_) {
  //   // Intentionally left blank
  // }
}

Future<void> showErrorDialog({
  required String errorDesc,
  required String errorTitle,
  required String buttonText,
  String? debugText,
}) async {
  if (debugText != null && debugText.isNotEmpty) {
    errorDesc += '\n\nDEBUG: $debugText';
  }
  BuildContext? context = Get.overlayContext;
  if (context == null) {
    return;
  } else {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(errorTitle),
        content: Text(errorDesc),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
