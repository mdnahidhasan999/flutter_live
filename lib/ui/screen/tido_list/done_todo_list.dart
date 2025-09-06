import 'package:flutter/material.dart';

import '../../../entities/todo.dart';
import '../../widget/todo_item.dart';

class DoneTodoListTab extends StatelessWidget {
  const DoneTodoListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),

          child: ToDoItem(
            todo: Todo('Title will be hear', ' description', DateTime.now()),
            onIconButtonPressed: () {},
          ),
        );
      },
    );
  }
}
