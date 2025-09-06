import 'package:flutter/material.dart';
import 'package:flutter_live/entities/todo.dart';
import 'package:flutter_live/ui/screen/tido_list/done_todo_list.dart';
import 'package:flutter_live/ui/screen/tido_list/undone_todo_list.dart';

import '../../widget/todo_item.dart';
import '../add_new_todoList.dart';
import 'all_todo_list.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
          bottom: TabBar(
            tabs: [Tab(text: 'All'), Tab(text: 'Done'), Tab(text: 'Undone')],
          ),
        ),
        body: TabBarView(
          children: [AllTodoListTab(), DoneTodoListTab(), UndDoneTodoListTab()],
        ),

        floatingActionButton: _buildAddTodoFloatingBtn(),
      ),
    );
  }

  FloatingActionButton _buildAddTodoFloatingBtn() {
    return FloatingActionButton.extended(
      tooltip: 'Add To-Do',
      backgroundColor: Colors.greenAccent,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddNewTodolist()),
        );
      },
      label: const Text('Add'),

      icon: const Icon(Icons.add),
    );
  }
}
