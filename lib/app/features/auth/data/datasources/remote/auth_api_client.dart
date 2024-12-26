import 'package:app_test/app/features/auth/data/datasources/auth_datasource.dart';
import 'package:app_test/app/features/auth/data/models/user.dart';
import 'package:app_test/core/conectivity/http_client.dart';

class AuthApiClient implements AuthDatasource {
  final HttpClient _httpClient;

  AuthApiClient(this._httpClient);

  @override
  Future<UserModel> login(UserModel user) async {
    final response = await _httpClient.post(
      'https://reqres.in/api/login',
      body: user.toJson(),
    );

    return UserModel(
      token: response.data['token'],
      email: user.email,
      id: response.data['id'],
    );
  }

  @override
  Future<UserModel> register(UserModel user) async {
    final response = await _httpClient.post(
      'https://reqres.in/api/register',
      body: user.toJson(),
    );

    return UserModel(
      token: response.data['token'],
      email: user.email,
      id: response.data['id'],
    );
  }
}
