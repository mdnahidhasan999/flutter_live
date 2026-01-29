import 'package:flutter/material.dart';
import 'package:flutter_live/ui/widgets/center_progress_indicator.dart';

import '../../data/models/network-response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/snackbar_message.dart';
import '../widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool isLoading = false;
  List<TaskModel> completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _getCompletedTasks,
        child: Visibility(
          visible: isLoading,
          replacement: CenterProgressIndicator(),

          child: ListView.builder(
            itemCount: completedTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: completedTaskList[index],
                onUpdateTask: () {
                  _getCompletedTasks();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTasks() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.completedTask,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      completedTaskList = taskListModel.taskList ?? [];
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
