import 'package:flutter/material.dart';
import 'package:flutter_live/entities/todo.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({
    super.key,
    required this.todo,
    required this.onIconButtonPressed,
  });

  final Todo todo;
  final VoidCallback onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      surfaceTintColor: _getColor(todo.done),
      color: _getBGColor(todo.done),
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: _getTextDecoration(todo.done),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(todo.description), Text(todo.time.toString())],
        ),
        trailing: _buildRoundedButton(todo.done),
      ),
    );
  }

  Widget _buildRoundedButton(bool done) {
    return GestureDetector(
      onTap: onIconButtonPressed,

      child: CircleAvatar(child: Icon(_getIcon(true))),
    );
  }

  IconData _getIcon(bool done) {
    return done ? Icons.check : Icons.close;
  }

  TextDecoration? _getTextDecoration(bool done) {
    return done ? TextDecoration.lineThrough : null;
  }

  Color? _getColor(bool done) {
    return done ? Colors.green : null;
  }

  Color? _getBGColor(bool done) {
    return done ? Colors.green.shade100 : null;
  }
}
