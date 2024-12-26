import 'package:flutter/material.dart';
import 'package:app_test/app/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test/app/features/tasks/presentation/widgets/card_task.dart';
import 'package:app_test/app/features/tasks/presentation/widgets/header.dart';
import 'package:app_test/app/features/tasks/presentation/widgets/resume_tasks.dart';
import 'package:app_test/generated/l10n.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with AutomaticKeepAliveClientMixin {
  late TasksCubit tasksCubit;

  @override
  void initState() {
    super.initState();
    tasksCubit = context.read<TasksCubit>();
    tasksCubit.getTasks(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is TasksLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              tasksCubit.getTasks(forceRefresh: true);
            },
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: TasksHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: ResumeTasks(tasks: state.cache.savedTasks),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(
                        S.current.recentTasks,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SliverList.separated(
                    itemCount: state.cache.tasks.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final task = state.cache.tasks[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/task-edit',
                            arguments: task,
                          );
                        },
                        child: TaskCard(
                          key: ValueKey(task.id),
                          task: task,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/task-edit');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
