import 'package:app_test/app/features/tasks/domain/entities/task.dart';

abstract class TasksDatasource {
  Future<List<TodoTask>> getTasks({
    bool forceRefresh = false,
  });
}
