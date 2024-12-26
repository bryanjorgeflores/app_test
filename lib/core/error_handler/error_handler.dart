import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ErrorHandler implements Exception {
  final dynamic error;

  ErrorHandler(this.error);

  static Failure handle(dynamic error, {bool showError = true}) {
    final Failure failure = switch (error) {
      DioException() => _handleDioError(error),
      Failure() => error,
      _ => Failure(
          code: '100',
          message: 'Unknown error',
        ),
    };

    return failure;
  }

  static Failure _handleDioError(DioException error) {
    if (error.type == DioExceptionType.unknown) {
      return Failure(code: '1', message: 'Unknown error');
    } else if (error.type == DioExceptionType.connectionError) {
      return Failure(code: '1', message: 'No internet connection');
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return Failure(code: '1', message: 'Connection timeout');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return Failure(code: '1', message: 'Receive timeout');
    } else if (error.type == DioExceptionType.sendTimeout) {
      return Failure(code: '1', message: 'Send timeout');
    }

    return Failure(
      code: '0',
      message: toBeginningOfSentenceCase(
        error.response?.data['error'] ?? 'Unknown error',
      ),
    );
  }
}

class Failure {
  final String code;
  final String message;

  Failure({
    required this.code,
    required this.message,
  });
}
