import 'package:app_test/app/features/auth/data/datasources/auth_datasource.dart';
import 'package:app_test/app/features/auth/data/models/user.dart';
import 'package:app_test/app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  const AuthRepositoryImpl(this._authDatasource);

  @override
  Future<UserModel> login(UserModel user) {
    return _authDatasource.login(user);
  }

  @override
  Future<UserModel> register(UserModel user) {
    return _authDatasource.register(user);
  }
}
