import 'package:flutter/material.dart';

import '../../../entities/todo.dart';
import '../../widget/todo_item.dart';

class DoneTodoListTab extends StatelessWidget {
  const DoneTodoListTab({
    super.key,
    required this.onDelete,
    required this.onStatusChange,
    required this.todoList,
  });

  final Function(int) onDelete;
  final Function(int) onStatusChange;
  final List<Todo> todoList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (_) {
            onDelete(index);
          },

          child: ToDoItem(
            todo: todoList[index],
            onIconButtonPressed: () {
              onStatusChange(index);
            },
          ),
        );
      },
    );
  }
}
