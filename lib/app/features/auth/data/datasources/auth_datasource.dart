import 'package:app_test/app/features/auth/data/models/user.dart';

abstract class AuthDatasource {
  Future<UserModel> login(UserModel user);
  Future<UserModel> register(UserModel user);
}
