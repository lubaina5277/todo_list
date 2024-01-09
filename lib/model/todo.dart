import 'dart:convert';

List<TodoList> todoListFromJson(String str) =>
    List<TodoList>.from(json.decode(str).map((x) => TodoList.fromJson(x)));

String todoListToJson(List<TodoList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoList {
  bool completed;
  String? task;
  dynamic id;

  TodoList({
    required this.completed,
    this.task,
    this.id,
  });

  factory TodoList.fromJson(Map<String, dynamic> json) => TodoList(
        completed: json["completed"],
        task: json["task"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "completed": completed,
        "task": task,
        "id": id,
      };
}