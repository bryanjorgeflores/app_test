import 'package:flutter/material.dart';
import 'package:app_test/app/features/tasks/domain/entities/task.dart';
import 'package:app_test/generated/l10n.dart';

class ResumeTasks extends StatelessWidget {
  final List<TodoTask> tasks;
  const ResumeTasks({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: WidgetItem(
            title: S.current.pending,
            color: const Color(0xff5694f2),
            count: tasks.where((element) => element.completed == false).length,
            icon: Icons.pending_actions,
          ),
        ),
        Expanded(
          child: WidgetItem(
            title: S.current.completed,
            color: const Color(0xff53c2c5),
            count: tasks.where((element) => element.completed == true).length,
            icon: Icons.checklist_sharp,
          ),
        ),
      ],
    );
  }
}

class WidgetItem extends StatelessWidget {
  final String title;
  final Color color;
  final int count;
  final IconData icon;
  const WidgetItem({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '$count ${S.current.tasks}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
