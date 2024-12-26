import 'package:fpdart/fpdart.dart';
import 'package:app_test/app/_shared/local_config.dart';
import 'package:app_test/app/features/auth/data/models/user.dart';
import 'package:app_test/app/features/auth/domain/entities/user.dart';
import 'package:app_test/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_test/core/error_handler/error_handler.dart';

class Login {
  final AuthRepository _authRepository;
  final AppLocalConfig localConfig;

  Login(this._authRepository, this.localConfig);

  Future<Either<Failure, User>> call(User credentials) async {
    try {
      final user = await _authRepository.login(
        UserModel(
          email: credentials.email,
          password: credentials.password,
        ),
      );

      localConfig.setUser(user: user);
      return Right(user);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, User>> getSavedUser() async {
    try {
      final user = localConfig.user;
      if (user == null) {
        return Left(Failure(code: '1', message: 'No user saved'));
      }
      return Right(user);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
