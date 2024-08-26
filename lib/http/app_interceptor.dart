import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:kombat_flutter/app/app_constant.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/utils/app_logger.dart';

class AppInterceptor extends Interceptor {
  AppService appService = Get.find<AppService>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers
    //     .addAll({"Accept-Language": appService.currentLang.value});
    // options.headers.addAll({"Currencytype": appService.currencyType.value});
    // options.headers.addAll({"Apptype": "10"});
    if (appService.tokenModel.value != null) {
      options.headers
          .addAll({"Authorization": appService.tokenModel.value?.apiToken});
    }
    // options.headers.addAll({
    //   "Nightmode": "${appService.darkThemeForAccountPage.value ? "2" : "1"}"
    // });
    // options.headers.addAll({"verison": "1.0.0+1"});
    // options.headers.addAll({"package": "com.example.kombat_flutter"});
    // options.headers.addAll({"DeviceId": appService.getDeviceId()});
    // options.headers.addAll({"DeviceModel": appService.getDeviceModel()});

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      if (response.data.runtimeType == String) {
        var json = jsonDecode(response.data);
        response.data = json;
      }
    } catch (e) {
      AppLogger.e(e);
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
