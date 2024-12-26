import 'package:app_test/app/features/tasks/data/datasources/tasks_datasource.dart';
import 'package:app_test/app/features/tasks/domain/entities/task.dart';
import 'package:app_test/app/features/tasks/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksDatasource _tasksDataSource;

  const TasksRepositoryImpl(this._tasksDataSource);

  @override
  Future<List<TodoTask>> getTasks({
    required int page,
    bool forceRefresh = false,
  }) async {
    return _tasksDataSource.getTasks(
      forceRefresh: forceRefresh,
    );
  }
}
