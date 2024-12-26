import 'package:fpdart/fpdart.dart';
import 'package:app_test/app/_shared/local_config.dart';
import 'package:app_test/core/error_handler/error_handler.dart';

class ManageDarkMode {
  final AppLocalConfig localConfig;

  ManageDarkMode(this.localConfig);

  Future<Either<Failure, bool>> call() async {
    try {
      return Right(localConfig.isDarkMode);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, bool>> setDarkMode({
    required bool isDarkMode,
  }) async {
    try {
      localConfig.setDarkMode(isDarkMode);
      return Right(isDarkMode);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
