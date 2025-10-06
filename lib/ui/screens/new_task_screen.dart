import 'package:flutter/material.dart';
import 'package:flutter_live/ui/utility/app_colors.dart';

import '../widgets/task_item.dart';
import '../widgets/task_summary_card.dart';
import 'add_new_task.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Column(
            children: [
              _buildSummarySection(),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return TaskItem();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onAddTask,
          backgroundColor: AppColors.themeColor,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  void _onAddTask() {
    // Logic to add a new task
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
  }

  Widget _buildSummarySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummaryCard(title: 'New Task', count: '34'),
          TaskSummaryCard(title: 'Completed', count: '34'),
          TaskSummaryCard(title: 'In Progress', count: '34'),
          TaskSummaryCard(title: 'Canceled', count: '34'),
        ],
      ),
    );
  }
}

//47
