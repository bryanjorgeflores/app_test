// To parse this JSON data, do
//
//     final todoTask = todoTaskFromJson(jsonString);

import 'dart:convert';

List<TodoTask> todoTaskFromJson(String str) =>
    List<TodoTask>.from(json.decode(str).map((x) => TodoTask.fromJson(x)));

String todoTaskToJson(List<TodoTask> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoTask {
  final int? id;
  final String? title;
  final bool? completed;
  final String? endDate;

  TodoTask({
    this.id,
    this.title,
    this.completed,
    this.endDate,
  });

  TodoTask copyWith({
    int? id,
    String? title,
    bool? completed,
    String? endDate,
  }) =>
      TodoTask(
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        endDate: endDate ?? this.endDate,
      );

  factory TodoTask.fromJson(Map<String, dynamic> json) => TodoTask(
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "completed": completed,
        "endDate": endDate,
      };
}
