import 'dart:io';
import 'package:app_test/core/conectivity/interceptors/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

export 'package:dio/dio.dart';

CacheOptions? cacheOptions;
HiveCacheStore? cacheStore;

class DioHelper {
  static final _singleton = DioHelper._();

  factory DioHelper() => _singleton;

  DioHelper._();

  final Dio dio = Dio();

  Future<void> init({
    required String baseUrl,
    String? token,
  }) async {
    try {
      dio.options.baseUrl = baseUrl;
      _configInterceptors();
    } catch (_) {}
  }

  void _configInterceptors() async {
    dio.interceptors.clear();
    dio.interceptors.add(RetryInterceptor());

    await configCache();

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  Future<void> configCache() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    cacheStore = HiveCacheStore(tempPath);
    cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
      hitCacheOnErrorExcept: [],
      maxStale: const Duration(days: 7),
      priority: CachePriority.high,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    );
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions!));
  }

  static void updateHeadersWithToken(String token) {
    _singleton.dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
  }

  static void updateUrl(String url) {
    _singleton.dio.options.baseUrl = url;
  }

  static Dio getInstance() => _singleton.dio;
}
