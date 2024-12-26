import 'package:flutter/material.dart';
import 'package:app_test/app/features/tasks/domain/entities/task.dart';
import 'package:app_test/app/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test/app/features/tasks/presentation/widgets/card_task.dart';
import 'package:app_test/generated/l10n.dart';

class TasksSavedPage extends StatefulWidget {
  const TasksSavedPage({super.key});

  @override
  State<TasksSavedPage> createState() => _TasksSavedPageState();
}

class _TasksSavedPageState extends State<TasksSavedPage> {
  late TasksCubit _tasksCubit;

  @override
  void initState() {
    super.initState();
    _tasksCubit = context.read<TasksCubit>();
    _tasksCubit.getSavedTasks();
  }

  Future<bool> _delete(TodoTask task) async {
    final response = await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.deleteTask),
        content: Text(S.current.deleteTaskDescription),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              S.current.cancel,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(S.current.yesDelete),
          ),
        ],
      ),
    );

    return response ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(S.current.savedTasks),
      ),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                _tasksCubit.getSavedTasks();
              },
              child: CustomScrollView(
                slivers: [
                  if (state.cache.savedTasks.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(S.current.noTasksSaved),
                      ),
                    ),
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      final task = state.cache.savedTasks[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/task-edit',
                            arguments: task,
                          );
                        },
                        child: Dismissible(
                          key: ValueKey(task.id),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (_) => _delete(task),
                          onDismissed: (_) {
                            _tasksCubit.deleteTask(task);
                          },
                          background: Container(
                            color: Theme.of(context).colorScheme.error,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  S.current.deleteTask,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onError,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 20,
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color:
                                        Theme.of(context).colorScheme.onError,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: TaskCard(
                            key: ValueKey(task.id),
                            task: task,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: state.cache.savedTasks.length,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
