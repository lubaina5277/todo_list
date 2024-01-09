import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../services/api_calls.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  late List<TodoList> allTasks;

  @override
  void initState() {
    allTasks = [];
    fetchAllTasks();
    super.initState();
  }

  fetchAllTasks() async {
    allTasks = await APICalls.fetchTodos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tasks'),
      ),
      body: ListView.builder(
        itemCount: allTasks.length,
        itemBuilder: (context, index) {
          final task = allTasks[index];
          return ListTile(
            title: Row(
              children: [
                Text(
                  task.task!,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration:
                        task.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
