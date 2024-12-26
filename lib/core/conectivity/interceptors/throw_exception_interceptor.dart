import 'package:dio/dio.dart';

class ThrowExceptionInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.reject(
      DioException.badResponse(
        statusCode: 401,
        requestOptions: options,
        response: Response(
          requestOptions: options,
          statusCode: 401,
        ),
      ),
      true,
    );
  }
}
