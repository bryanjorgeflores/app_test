import 'package:fpdart/fpdart.dart';
import 'package:app_test/app/_shared/local_config.dart';
import 'package:app_test/app/features/auth/data/models/user.dart';
import 'package:app_test/app/features/auth/domain/entities/user.dart';
import 'package:app_test/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_test/core/error_handler/error_handler.dart';

class Register {
  final AuthRepository _authRepository;
  final AppLocalConfig localConfig;

  Register(this._authRepository, this.localConfig);

  Future<Either<Failure, User>> call(User credentials) async {
    try {
      final user = await _authRepository.register(
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
}
