import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text('Task Title'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This is a description of task Description'),
            Text(
              'Due Date: 2024-12-31',
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
                  label: Text('New'),
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
