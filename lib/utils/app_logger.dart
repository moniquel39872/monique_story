import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _log = Logger();

  static e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  static d(dynamic message) {
    _log.d(message);
  }

  static w(dynamic message) {
    _log.w(message);
  }

  static i(dynamic message) {
    _log.i(message);
  }
}
