
import 'package:app_test/app/features/tasks/data/datasources/tasks_datasource.dart';
import 'package:app_test/app/features/tasks/domain/entities/task.dart';
import 'package:app_test/core/conectivity/http_client.dart';

class TasksApiClient implements TasksDatasource {
  final HttpClient _httpClient;

  TasksApiClient(this._httpClient);


  @override
  Future<List<TodoTask>> getTasks({bool forceRefresh = false}) async {
    final response = await _httpClient.get(
      '/todos',
      forceRefresh: forceRefresh,
    );

    final List<TodoTask> tasks =
        (response.data as List).map((task) => TodoTask.fromJson(task)).toList();
    return tasks;
  }
}
