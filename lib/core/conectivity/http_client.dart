abstract class HttpClient {
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
    bool forceRefresh = false,
  });

  Future<HttpResponse> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  Future<HttpResponse> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  Future<HttpResponse> patch(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });

  Future<HttpResponse> delete(
    String url, {
    Map<String, String>? headers,
  });

  void addHeaders(Map<String, dynamic>? headers);

  void updateHeader(String key, String value);

  Future<void> setAuthToken(String token);

  void removeHeader(String header);

  Future<void> setBaseUrl(String url);

  void setExtraData(Map<String, dynamic> data);
}

class HttpResponse<T> {
  HttpResponse({
    this.data,
    this.requestOptions,
    this.statusCode = 0,
    this.statusMessage = '',
    this.extra = const {},
    this.headers = const {},
  });

  T? data;

  dynamic requestOptions;
  final int statusCode;
  final String statusMessage;
  Map<String, dynamic> extra;
  final Map<String, dynamic> headers;
}
