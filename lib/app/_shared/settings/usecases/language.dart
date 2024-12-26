import 'package:fpdart/fpdart.dart';
import 'package:app_test/app/_shared/local_config.dart';
import 'package:app_test/core/error_handler/error_handler.dart';

class ManageLanguage {
  final AppLocalConfig localConfig;

  ManageLanguage(this.localConfig);

  Future<Either<Failure, String>> call() async {
    try {
      return Right(localConfig.locale);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, bool>> setLocale({
    required String locale,
  }) async {
    try {
      localConfig.setLocale(locale);
      return Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
