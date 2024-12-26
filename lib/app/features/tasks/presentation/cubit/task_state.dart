part of 'task_cubit.dart';

abstract class TasksState extends Equatable {
  const TasksState(this.cache);
  final PokemonStateCache cache;

  @override
  List<Object> get props => [cache];
}

class TasksInitial extends TasksState {
  const TasksInitial(super.cache);
}

class TasksLoading extends TasksState {
  const TasksLoading(super.cache);
}

class TasksLoaded extends TasksState {
  const TasksLoaded(super.cache);
}

class TasksError extends TasksState {
  final String message;

  const TasksError(super.cache, {required this.message});
}

class TasksSavedLoaded extends TasksState {
  const TasksSavedLoaded(super.cache);
}

class SavingTask extends TasksState {
  const SavingTask(super.cache);
}

class TaskSaved extends TasksState {
  const TaskSaved(super.cache);
}

class DeletingTask extends TasksState {
  const DeletingTask(super.cache);
}

class TaskDeleted extends TasksState {
  const TaskDeleted(super.cache);
}

class TaskSaveError extends TasksState {
  final String message;

  const TaskSaveError(super.cache, {required this.message});
}

class TaskDeleteError extends TasksState {
  final String message;

  const TaskDeleteError(super.cache, {required this.message});
}

class UpdatingTask extends TasksState {
  const UpdatingTask(super.cache);
}

class TaskUpdated extends TasksState {
  const TaskUpdated(super.cache);
}

class TaskUpdateError extends TasksState {
  final String message;

  const TaskUpdateError(super.cache, {required this.message});
}

class PokemonStateCache extends Equatable {
  final List<TodoTask> tasks;
  final List<TodoTask> savedTasks;

  const PokemonStateCache({
    this.tasks = const [],
    this.savedTasks = const [],
  });

  const PokemonStateCache.initial()
      : tasks = const [],
        savedTasks = const [];

  @override
  List<Object> get props => [tasks, savedTasks];

  PokemonStateCache copyWith({
    List<TodoTask>? tasks,
    List<TodoTask>? savedTasks,
  }) {
    return PokemonStateCache(
      tasks: tasks ?? this.tasks,
      savedTasks: savedTasks ?? this.savedTasks,
    );
  }
}
