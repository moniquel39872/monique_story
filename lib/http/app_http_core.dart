import 'package:dio/dio.dart';
import 'package:kombat_flutter/http/app_error_interceptor.dart';
import '../app/app_constant.dart';
import 'app_interceptor.dart';

class AppHttpCore {
  late Dio dio;
  late String baseUrl;

  factory AppHttpCore({required String baseUrl}) {
    var instance = AppHttpCore._internal(baseUrl);
    return instance;
  }

  // Private constructor
  AppHttpCore._internal(String mbaseUrl) {
    baseUrl = mbaseUrl;
    initDio();
  }

  void initDio() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      // connectTimeout : Duration(seconds: 300),
      // receiveTimeout  : Duration(seconds: 300),
      // sendTimeout: Duration(seconds: 5)
    );
    dio = Dio(baseOptions);
    if (baseUrl == AppConstant.getBaseUrl()) {
      dio.interceptors.add(AppInterceptor());
    }

    // dio.interceptors.add(LogInterceptor(
    //   // responseBody: true,
    //   request: false,
    //   requestHeader: false,
    //   requestBody: true,
    //   responseHeader: false,
    //   responseBody: true
    // ));
  }
}
