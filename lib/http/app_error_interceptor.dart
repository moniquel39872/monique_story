
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kombat_flutter/http/exceptions.dart';


class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.badResponse:
        String message = '';
        final String? content = err.response?.data?.toString();
        if ((content ?? '') != '') {
          try {
            final decode = jsonDecode(content!) as Map<String, dynamic>;
            message = decode['message'] as String;
          } catch (error) {
            message = error.toString();
          }
        }

        final String key = message;
        final int? status = err.response?.statusCode;
        if (status == null) {
          throw NetworkException(
            status: HttpStatus.networkConnectTimeoutError,
            message: err.message,
          );
        } else {
          switch (status) {
            case HttpStatus.unauthorized:
              throw AuthorizationException(
                key: key,
                status: status,
                message: message,
              );
            case HttpStatus.unprocessableEntity:
              throw ValidationException(
                key: key,
                status: status,
                message: message,
              );
            case HttpStatus.notFound:
              throw NotFoundException(
                key: key,
                status: status,
                message: message,
              );
            default:
              throw StatusException(key: key, status: status, message: message);
          }
        }
      case DioExceptionType.cancel:
        //Get.find<AppService>().fbCancelToken = null;
        throw CancelRequestException(
          status: HttpStatus.clientClosedRequest,
          message: err.toString(),
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw NetworkException(
          status: HttpStatus.networkConnectTimeoutError,
          message: err.message,
        );
    }
  }
}
