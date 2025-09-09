import 'package:flutter/material.dart';
import 'package:flutter_live/entities/todo.dart';
import 'package:flutter_live/ui/screen/tido_list/done_todo_list.dart';
import 'package:flutter_live/ui/screen/tido_list/undone_todo_list.dart';

import '../add_new_todoList.dart';
import 'all_todo_list.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todoList = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
          bottom: TabBar(
            tabs: [Tab(text: 'All'), Tab(text: 'Undone'), Tab(text: 'Done')],
          ),
        ),
        body: TabBarView(
          children: [
            AllTodoListTab(
              onDelete: (int index) {
                _deleteTodo(index);
              },
              onStatusChange: (int index) {
                _toggleTodoStatus(index);
              },
              todoList: _todoList,
            ),

            UndDoneTodoListTab(
              onDelete: (int index) {
                _deleteTodo(index);
              },
              onStatusChange: (int index) {
                _toggleTodoStatus(index);
              },
              todoList: _todoList.where((todo) => !todo.done).toList(),
            ),
            DoneTodoListTab(
              onDelete: (int index) {
                _deleteTodo(index);
              },
              onStatusChange: (int index) {
                _toggleTodoStatus(index);
              },
              todoList: _todoList.where((todo) => todo.done).toList(),
            ),
          ],
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
          MaterialPageRoute(
            builder: (context) => AddNewTodolist(onAddTodo: _addNewTodo),
          ),
        );
      },
      label: const Text('Add'),

      icon: const Icon(Icons.add),
    );
  }

  void _addNewTodo(Todo todo) {
    _todoList.add(todo);
    if (mounted) {
      setState(() {});
    }
  }

  void _deleteTodo(int index) {
    _todoList.removeAt(index);
    if (mounted) {
      setState(() {});
    }
  }

  void _toggleTodoStatus(int index) {
    _todoList[index].done = !_todoList[index].done;
    if (mounted) {
      setState(() {});
    }
  }
}
