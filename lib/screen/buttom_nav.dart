import 'package:flutter/material.dart';


import 'all_task.dart';
import 'complete_task.dart';
import 'todo_screen.dart';

class BottonNavScreen extends StatefulWidget {
  const BottonNavScreen({super.key});

  @override
  State<BottonNavScreen> createState() => _BottonNavScreenState();
}

class _BottonNavScreenState extends State<BottonNavScreen> {
  int curIndex = 0;
  List pages = [TodoScreen(), AllTask(), CompletedTask()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[curIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curIndex,
        onTap: (value) {
          curIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.pending_actions), label: "Pending & Insert"),
          BottomNavigationBarItem(icon: Icon(Icons.density_small), label: "All"),
          BottomNavigationBarItem(
              icon: Icon(Icons.task), label: "Completed"),
          
        ],
      ),
    );
  }
}
