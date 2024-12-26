import 'package:app_test/app/features/tasks/domain/entities/task.dart';

abstract class TasksRepository {
  Future<List<TodoTask>> getTasks({
    required int page,
    bool forceRefresh = false,
  });
}
