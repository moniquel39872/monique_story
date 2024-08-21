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
    options.headers
        .addAll({"Accept-Language": appService.currentLang.value});
    // options.headers.addAll({"Currencytype": appService.currencyType.value});
    options.headers.addAll({"Apptype": "10"});
    if(appService.tokenModel.value!=null){
      options.headers.addAll({"Authorization": appService.tokenModel.value?.apiToken});
    }
    // options.headers.addAll({
    //   "Nightmode": "${appService.darkThemeForAccountPage.value ? "2" : "1"}"
    // });
    options.headers.addAll({"verison": "1.0.0+1"});
    options.headers.addAll({"package": "com.example.kombat_flutter"});
    options.headers.addAll({"DeviceId": appService.getDeviceId()});
    options.headers.addAll({"DeviceModel": appService.getDeviceModel()});
    // if (appService.isLogin.value) {
    //   options.headers.addAll({"Id": "${appService.sp188Token.value.id ?? 0}"});
    // }
    options.headers
        .addAll({"LoginFrom": "${kIsWeb ? 5 : Platform.isAndroid ? 3 : 2}"});
    options.headers.addAll({"HostUrl": AppConstant.getBaseUrl()});

    // options.headers.addAll({"Origin": "${AppConstant.getBaseUrl()}"});
    options.headers
        .addAll({"Token": "${appService.tokenModel.value?.apiToken}"});
    // options.headers
    //     .addAll({"Account": "${appService.loginInfoModel.value?.account}"});

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      if (response.data.runtimeType == String) {
        var json = jsonDecode(response.data);
        if (json['code'] == 666) {
          appService.onLogOut();
          handler.reject(DioException(
              requestOptions: response.requestOptions, response: response));
        }
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
