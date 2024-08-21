import 'dart:async';
import 'package:dio/dio.dart';

Future<void>? redirectToLoginFuture;

mixin ApiHandler {
  Future<void> apiErrorHandler(
    Function() body, {
    FutureOr<void> Function(Object)? onError,
  }) async {
    try {
      await body();
    } on DioException catch (e) {
      if (onError != null) {
        await onError(e);
      }
      // 添加网络异常相关的预处理逻辑，token过期等

      rethrow;
    } catch (e) {
      if (onError != null) {
        await onError(e);
      }
      rethrow;
    }
  }
}
