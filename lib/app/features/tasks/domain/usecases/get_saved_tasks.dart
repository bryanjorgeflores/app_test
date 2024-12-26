import 'package:fpdart/fpdart.dart';
import 'package:app_test/app/features/tasks/domain/entities/task.dart';
import 'package:app_test/core/error_handler/error_handler.dart';
import 'package:app_test/core/sqlite/sqlite.dart';

class GetSavedTasks {
  Future<Either<Failure, List<TodoTask>>> call() async {
    try {
      final pokemon = await SQLiteHelper().getTasks();
      return Right(pokemon);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, int?>> saveTask(TodoTask task) async {
    try {
      final value = await SQLiteHelper().insertTask(task);
      return Right(value);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, int?>> deleteTask(TodoTask task) async {
    try {
      final value = await SQLiteHelper().deleteTask(task);
      return Right(value);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, int?>> updateTask(TodoTask task) async {
    try {
      final value = await SQLiteHelper().updateTask(task);
      if (value == 0) {
        final newTaskValue = await SQLiteHelper().insertTask(task);
        return Right(newTaskValue);
      }
      return Right(value);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
