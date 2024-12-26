import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app_test/app/features/tasks/domain/entities/task.dart';
import 'package:app_test/app/features/tasks/domain/usecases/get_saved_tasks.dart';
import 'package:app_test/app/features/tasks/domain/usecases/get_tasks.dart';

part 'task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GetTasks _getTasks;
  final GetSavedTasks _getSavedTasks;
  TasksCubit(
    this._getTasks,
    this._getSavedTasks,
  ) : super(const TasksInitial(PokemonStateCache.initial()));

  void getTasks({
    int page = 0,
    bool forceRefresh = false,
  }) async {
    emit(TasksLoading(
      state.cache,
    ));
    final tasks = await _getTasks(
      page: page,
      forceRefresh: forceRefresh,
    );

    tasks.fold(
      (failure) => emit(TasksError(state.cache, message: failure.message)),
      (tasks) => emit(TasksLoaded(state.cache.copyWith(tasks: tasks))),
    );
  }

  void getSavedTasks() async {
    emit(TasksLoading(
      state.cache,
    ));
    final tasks = await _getSavedTasks();

    tasks.fold(
      (failure) => emit(TasksError(state.cache, message: failure.message)),
      (savedTasks) => emit(TasksSavedLoaded(
        state.cache.copyWith(savedTasks: savedTasks),
      )),
    );
  }

  void saveTask(TodoTask task) async {
    emit(SavingTask(state.cache));
    final result = await _getSavedTasks.saveTask(task);

    result.fold(
      (failure) => emit(
        TaskSaveError(
          state.cache,
          message: failure.message,
        ),
      ),
      (_) => emit(
        TaskSaved(
          state.cache.copyWith(
            savedTasks: state.cache.savedTasks..add(task),
          ),
        ),
      ),
    );
  }

  void deleteTask(TodoTask task) async {
    emit(DeletingTask(state.cache));
    final result = await _getSavedTasks.deleteTask(task);

    result.fold(
      (failure) => emit(
        TaskDeleteError(
          state.cache,
          message: failure.message,
        ),
      ),
      (_) => emit(
        TaskDeleted(
          state.cache.copyWith(
            savedTasks: state.cache.savedTasks
              ..removeWhere(
                (existingTask) => existingTask.id == task.id,
              ),
          ),
        ),
      ),
    );
  }

  void updateTask(TodoTask task) async {
    emit(UpdatingTask(state.cache));
    final result = await _getSavedTasks.updateTask(task);
    result.fold(
      (failure) => emit(
        TaskUpdateError(
          state.cache,
          message: failure.message,
        ),
      ),
      (_) {
        final updatedTasks = List<TodoTask>.from(state.cache.savedTasks)
          ..removeWhere((existingTask) => existingTask.id == task.id)
          ..add(task);
        emit(
          TaskUpdated(
            state.cache.copyWith(savedTasks: updatedTasks),
          ),
        );
      },
    );
  }
}
