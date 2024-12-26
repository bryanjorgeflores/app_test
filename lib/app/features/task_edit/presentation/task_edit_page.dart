import 'package:flutter/material.dart';
import 'package:app_test/app/_shared/settings/cubit/settings_cubit.dart';
import 'package:app_test/app/features/tasks/domain/entities/task.dart';
import 'package:app_test/app/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:app_test/app/features/tasks/widgets/textfield.dart';
import 'package:app_test/app/features/tasks/widgets/toast.dart';
import 'package:app_test/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskEditPage extends StatefulWidget {
  final TodoTask? task;
  const TaskEditPage({super.key, this.task});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  late TasksCubit _tasksCubit;
  final taskForm = FormGroup(
    {
      'title': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      'completed': FormControl<bool>(
        value: false,
        validators: [
          Validators.required,
        ],
      ),
      'endDate': FormControl<DateTime>(
        validators: [
          Validators.required,
        ],
      ),
    },
  );

  @override
  void initState() {
    super.initState();
    _tasksCubit = context.read<TasksCubit>();
    if (widget.task != null) {
      taskForm.patchValue({
        'title': widget.task!.title,
        'completed': widget.task!.completed,
        'endDate': widget.task!.endDate != null
            ? DateTime.parse(widget.task!.endDate!)
            : null,
      });
    }
  }

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: taskForm.control('endDate').value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != taskForm.control('endDate').value) {
      taskForm.control('endDate').value = picked;
    }
  }

  void _tasksListener(BuildContext context, TasksState state) {
    if (state is TaskUpdated) {
      Toast.show(
        context,
        S.current.taskUpdatedSuccessfully,
      );
      Navigator.of(context).pop();
    }
    if (state is TaskUpdateError) {
      Toast.show(
        context,
        state.message,
        color: Theme.of(context).colorScheme.error,
      );
    }
  }

  _updateOrSaveTask() {
    if (taskForm.valid) {
      _tasksCubit.updateTask(TodoTask(
        id: widget.task?.id,
        title: taskForm.control('title').value,
        completed: taskForm.control('completed').value,
        endDate: taskForm.control('endDate').value.toIso8601String(),
      ));
    } else {
      for (final control in taskForm.controls.entries) {
        control.value.markAsDirty();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<TasksCubit, TasksState>(
        listener: _tasksListener,
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ReactiveForm(
              formGroup: taskForm,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task == null
                                ? S.current.createTask
                                : S.current.editTask,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            formControlName: 'title',
                            hintText: S.current.title,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            formControlName: 'endDate',
                            hintText: S.current.endDateTask,
                            readOnly: true,
                            onTap: _selectDate,
                          ),
                          const SizedBox(height: 16),
                          ReactiveCheckboxListTile(
                            formControlName: 'completed',
                            title: Text(
                              S.current.completedTask,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            tileColor: state.cache.isDarkMode
                                ? Theme.of(context).colorScheme.onSecondary
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (taskForm.valid) {
                                  _updateOrSaveTask();
                                } else {
                                  for (final control
                                      in taskForm.controls.entries) {
                                    control.value.markAsDirty();
                                  }
                                  Toast.show(
                                    context,
                                    S.current.pleaseFillFields,
                                    color: Theme.of(context).colorScheme.error,
                                  );
                                }
                              },
                              child: Text(
                                S.current.save,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
