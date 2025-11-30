import 'package:flutter/material.dart';
import 'package:flutter_live/data/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text(taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.description ?? ''),
            Text(
              'Due Date: ${taskModel.createdDate}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(taskModel.status ?? 'New'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  backgroundColor: Colors.green[100],
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                SizedBox(width: 8),
                ButtonBar(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: Colors.blue, size: 20),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete, color: Colors.red, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
