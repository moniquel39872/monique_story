
library http;

class StatusException implements Exception {
  StatusException({
    required this.status,
    required this.message,
    this.key,
  });

  final int status;
  final String? message;
  final String? key;

  @override
  String toString() {
    return 'http request exception [$status]: $message';
  }
}

class NotFoundException extends StatusException {
  NotFoundException({
    required super.status,
    required super.message,
    super.key,
  });
}

class AuthorizationException extends StatusException {
  AuthorizationException({
    required super.status,
    required super.message,
    super.key,
  });
}

class ValidationException extends StatusException {
  ValidationException({
    required super.status,
    required super.message,
    super.key,
  });
}

class NetworkException extends StatusException {
  NetworkException({
    required super.status,
    required super.message,
    super.key,
  });
}

class CancelRequestException extends StatusException {
  CancelRequestException({
    required super.status,
    required super.message,
    super.key,
  });
}
