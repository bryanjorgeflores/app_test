import 'dart:async';
import 'package:app_test/core/conectivity/helpers/dio_helper.dart';

class RetryInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final RetryOptions retryOptions =
        options.extra.containsKey(RetryOptions.extraKey)
            ? RetryOptions.fromExtra(options)
            : const RetryOptions(retries: 0);

    if (retryOptions.isUnauthorized) {
      handler.reject(
        DioException.requestCancelled(
          requestOptions: options,
          reason: 'isUnauthorized',
        ),
      );
      return;
    }

    super.onRequest(options, handler);
  }

  Future<dynamic> retryRequest(DioException err) async {
    try {
      final dio = DioHelper.getInstance();
      return await dio.fetch(err.requestOptions);
    } catch (e) {
      return e;
    }
  }
}

class RetryOptions {
  final int retries;
  final bool isRefreshing;
  final bool isUnauthorized;

  const RetryOptions({
    required this.retries,
    this.isRefreshing = true,
    this.isUnauthorized = false,
  });

  final retryInterval = const Duration(milliseconds: 1500);
  static const extraKey = 'retry_request';

  static bool retryEvaluator(DioException err) {
    final statusCode = (err.response?.statusCode ?? 0);
    final leftRetries = RetryOptions.fromExtra(err.requestOptions).retries;

    return (statusCode > 500 || statusCode == 401) && leftRetries > 0;
  }

  factory RetryOptions.fromExtra(RequestOptions request) {
    return request.extra[extraKey];
  }

  RetryOptions copyWith({
    int? retries,
    bool? isRefreshing,
    bool? isUnauthorized,
  }) {
    return RetryOptions(
      retries: retries ?? this.retries,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isUnauthorized: isUnauthorized ?? this.isUnauthorized,
    );
  }

  Map<String, dynamic> toExtra() {
    return {extraKey: this};
  }
}
