import 'dart:convert';

import 'package:app_test/core/conectivity/http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_test/app/features/auth/domain/entities/user.dart';

class AppLocalConfig {
  HttpClient _httpClient;
  AppLocalConfig(this._httpClient);
  late FlutterSecureStorage _secureStorage;
  static User? _user;
  static bool _isDarkMode = false;
  static String _locale = 'en';

  Future<void> init() async {
    _secureStorage = const FlutterSecureStorage();
    final userSaved = await _secureStorage.read(key: '_user');
    if (userSaved != null) {
      setUser(user: User.fromJson(jsonDecode(userSaved)));
    }

    final isDarkModeSaved = await _secureStorage.read(key: '_isDarkMode');
    if (isDarkModeSaved != null) {
      _isDarkMode = isDarkModeSaved == 'true';
    }

    final localeSaved = await _secureStorage.read(key: '_locale');
    if (localeSaved != null) {
      _locale = localeSaved;
    }
  }

  User? get user => _user;
  Future<void> setUser({User? user}) async {
    if (user == null) {
      _user = null;
      await _secureStorage.delete(key: '_user');
      _httpClient.removeHeader('Authorization');
      await _httpClient.setBaseUrl('https://reqres.in/api');
      return;
    }
    _user = user;
    await _secureStorage.write(key: '_user', value: jsonEncode(user.toJson()));
    await _httpClient.setBaseUrl('https://jsonplaceholder.typicode.com');
    await _httpClient.setAuthToken(user.token ?? '');
  }

  bool get isDarkMode => _isDarkMode;
  Future<void> setDarkMode(bool isDarkMode) async {
    _isDarkMode = isDarkMode;
    await _secureStorage.write(
        key: '_isDarkMode', value: isDarkMode.toString());
  }

  String get locale => _locale;
  Future<void> setLocale(String locale) async {
    _locale = locale;
    await _secureStorage.write(key: '_locale', value: locale);
  }
}
