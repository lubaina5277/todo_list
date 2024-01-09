import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../services/api_calls.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  late List<TodoList> completedTasks = [];

  @override
  void initState() {
    super.initState();
    fetchCompletedTasks();
  }

  Future<void> fetchCompletedTasks() async {
    try {
      final tasks = await APICalls.fetchCompletedTasks();
      setState(() {
        completedTasks = tasks;
      });
    } catch (e) {
      print('Error fetching completed tasks: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (completedTasks.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Completed Tasks'),
        ),
        body: Center(child: Text('No completed tasks.')),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Completed Tasks'),
        ),
        body: ListView.builder(
          itemCount: completedTasks.length,
          itemBuilder: (context, index) {
            final task = completedTasks[index];
            return ListTile(
              title: Text(task.task!),
            );
          },
        ),
      );
    }
  }
}
