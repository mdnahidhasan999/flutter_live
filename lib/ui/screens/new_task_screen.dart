import 'package:flutter/material.dart';
import 'package:flutter_live/data/models/network-response.dart';
import 'package:flutter_live/data/models/task_count_status.dart';
import 'package:flutter_live/data/models/task_list_wrapper_model.dart';
import 'package:flutter_live/data/models/task_model.dart';
import 'package:flutter_live/data/network_caller/network_caller.dart';
import 'package:flutter_live/data/utilities/urls.dart';
import 'package:flutter_live/ui/utility/app_colors.dart';
import 'package:flutter_live/ui/widgets/center_progress_indicator.dart';
import 'package:flutter_live/ui/widgets/snackbar_message.dart';

import '../../data/models/task_status_model.dart';
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
  bool isLoadingProgress = false;

  List<TaskModel> newTaskList = [];
  List<TaskCountStatus> taskCountStatusList = [];

  @override
  void initState() {
    super.initState();
    _getTasksCountByStatus();
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
                    _getNewTasks();
                    _getTasksCountByStatus();
                  },
                  child: Visibility(
                    visible: isLoading == false,
                    replacement: CenterProgressIndicator(),
                    child: ListView.builder(
                      itemCount: newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskItem(
                          taskModel: newTaskList[index],
                          onUpdateTask: () {
                            _getNewTasks();
                            _getTasksCountByStatus();
                          },
                        );
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
    return Visibility(
      visible: isLoadingProgress == false,
      replacement: SizedBox(height: 100, child: CenterProgressIndicator()),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              taskCountStatusList.map((e) {
                return TaskSummaryCard(
                  title: (e.sId ?? 'Unknown').toUpperCase(),
                  count: e.sum.toString(),
                );
              }).toList(),
        ),
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

  Future<void> _getTasksCountByStatus() async {
    isLoadingProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.taskStatusCount,
    );
    if (response.isSuccess) {
      TaskCountModel taskListModel = TaskCountModel.fromJson(
        response.responseData,
      );
      taskCountStatusList = taskListModel.taskCountStatusList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ??
              'Get task count by satus failed! Please try again',
        );
      }
    }
    isLoadingProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}


