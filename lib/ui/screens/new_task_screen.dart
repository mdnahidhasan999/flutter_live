import 'package:flutter/material.dart';
import 'package:flutter_live/data/models/network-response.dart';
import 'package:flutter_live/data/models/task_list_wrapper_model.dart';
import 'package:flutter_live/data/models/task_model.dart';
import 'package:flutter_live/data/network_caller/network_caller.dart';
import 'package:flutter_live/data/utilities/urls.dart';
import 'package:flutter_live/ui/utility/app_colors.dart';
import 'package:flutter_live/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_live/ui/widgets/snackbar_message.dart';

import '../widgets/task_item.dart';
import '../widgets/task_summary_card.dart';
import 'add_new_task.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool isLoading = false;
  List<TaskModel> newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getNewTasks();
  }

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
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _getNewTasks();
                  },
                  child: Visibility(
                    visible: isLoading == false,
                    replacement: CenterProgressIndicator(),
                    child: ListView.builder(
                      itemCount: newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskItem(taskModel: newTaskList[index]);
                      },
                    ),
                  ),
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

  Future<void> _getNewTasks() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      newTaskList = taskListModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Getting new tasks failed! Please try again',
        );
      }
    }
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }
}

//47
