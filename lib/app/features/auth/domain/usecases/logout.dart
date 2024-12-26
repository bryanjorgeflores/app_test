import 'package:app_test/core/conectivity/helpers/dio_helper.dart';
import 'package:fpdart/fpdart.dart';
import 'package:app_test/app/_shared/local_config.dart';
import 'package:app_test/core/error_handler/error_handler.dart';

class Logout {
  final AppLocalConfig localConfig;

  Logout(this.localConfig);

  Future<Either<Failure, bool>> call() async {
    try {
      localConfig.setUser(user: null);
      cacheStore?.clean();
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
