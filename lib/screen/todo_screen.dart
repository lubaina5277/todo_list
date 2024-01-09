import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../services/api_calls.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late List<TodoList> todos;
  List<int> updatedTaskIds = [];
  TextEditingController _taskTxtController = TextEditingController();

  @override
  void initState() {
    todos = [];
    fetchAllTodos();
    super.initState();
  }

  fetchAllTodos() async {
    todos = await APICalls.fetchTodos();
    setState(() {});
  }

  List<TodoList> getPendingTasks() {
    return todos.where((task) => !task.completed).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pendingTasks = getPendingTasks();

    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskTxtController,
                    decoration: InputDecoration(
                      hintText: 'Enter task name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius here
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (_taskTxtController.text.isNotEmpty) {
                      await APICalls.addTodo(_taskTxtController.text);
                      _taskTxtController.clear();
                      fetchAllTodos();
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Text(
            "Pending Tasks",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                fetchAllTodos();
              },
              child: ListView.builder(
                itemCount: pendingTasks.length,
                itemBuilder: (context, index) {
                  final task = pendingTasks[index];
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: IconButton(
                      onPressed: () async {
                        await APICalls.deleteTodo(task.id!);
                        fetchAllTodos();
                      },
                      icon: Icon(Icons.delete),
                    ),
                    onChanged: (v) async {
                      await APICalls.updateTodo(task.id!, v!);

                      if (!todos[index].completed) {
                        updatedTaskIds.add(task.id!);
                      } else {
                        updatedTaskIds.remove(task.id);
                      }
                      await APICalls.updateTodo(task.id!, v);
                      fetchAllTodos();
                    },
                    value: task.completed,
                    title: Text(
                      task.task!,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
