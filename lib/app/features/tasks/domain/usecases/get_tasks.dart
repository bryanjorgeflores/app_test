import 'package:fpdart/fpdart.dart';
import 'package:app_test/app/features/tasks/domain/entities/task.dart';
import 'package:app_test/app/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:app_test/core/error_handler/error_handler.dart';

class GetTasks {
  GetTasks(this._pokemonRepository);

  final TasksRepository _pokemonRepository;

  Future<Either<Failure, List<TodoTask>>> call({
    required int page,
    bool forceRefresh = false,
  }) async {
    try {
      final tasks = await _pokemonRepository.getTasks(
        page: page,
        forceRefresh: forceRefresh,
      );

      return Right(tasks);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
