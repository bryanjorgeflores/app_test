import 'dart:io';

import 'package:app_test/core/conectivity/helpers/dio_helper.dart';
import 'package:app_test/core/conectivity/http_client.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class HttpClientDio extends HttpClient {
  final Dio dio;
  HttpClientDio(this.dio);

  @override
  void addHeaders(Map<String, dynamic>? headers) {
    if (headers == null) return;
    dio.options.headers.addAll(headers);
  }

  @override
  void updateHeader(String key, String value) {
    Map<String, dynamic>? header = dio.options.headers[key];
    if (header == null) return;
    dio.options.headers[key] = value;
  }

  @override
  Future<void> setAuthToken(String token) async {
    if (dio.options.headers[HttpHeaders.authorizationHeader] == null) {
      dio.options.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
    } else {
      dio.options.headers.update(
        HttpHeaders.authorizationHeader,
        (v) => 'Bearer $token',
      );
    }
    print(dio.options.headers);
  }

  @override
  void removeHeader(String header) {
    dio.options.headers.remove(header);
  }

  @override
  Future<void> setBaseUrl(String url) async {
    dio.options.baseUrl = url;
  }

  @override
  Future<HttpResponse> delete(
    String url, {
    Map<String, String>? headers,
  }) async {
    final resp = await dio.delete(
      url,
      options: Options(headers: headers ?? {}),
    );
    return _map(resp);
  }

  @override
  Future<HttpResponse> patch(
    String url, {
    Map<String, String>? headers,
    body,
  }) async {
    final resp = await dio.patch(
      url,
      data: body,
      options: Options(headers: headers ?? {}),
    );
    return _map(resp);
  }

  @override
  Future<HttpResponse> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final resp = await dio.post(
      url,
      data: body,
      options: Options(headers: headers ?? {}),
    );
    return _map(resp);
  }

  @override
  Future<HttpResponse> put(
    String url, {
    Map<String, String>? headers,
    body,
  }) async {
    final resp = await dio.put(
      url,
      data: body,
      options: Options(headers: headers ?? {}),
    );
    return _map(resp);
  }

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
    bool forceRefresh = false,
  }) async {
    final resp = await dio.get(
      url,
      options: forceRefresh
          ? cacheOptions
              ?.copyWith(policy: CachePolicy.refreshForceCache)
              .toOptions()
              .copyWith(
                headers: headers,
              )
          : Options(
              headers: headers,
            ),
    );
    return _map(resp);
  }

  HttpResponse _map(Response dioResp) {
    return HttpResponse(
      data: dioResp.data,
      requestOptions: dioResp.requestOptions,
      statusCode: dioResp.statusCode ?? 0,
      statusMessage: dioResp.statusMessage ?? '',
      extra: dioResp.extra,
      headers: dioResp.headers.map,
    );
  }

  @override
  void setExtraData(Map<String, dynamic> data) {
    dio.options.extra.addAll(data);
  }
}
