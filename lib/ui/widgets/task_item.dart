import 'package:flutter/material.dart';
import 'package:flutter_live/data/models/task_model.dart';
import 'package:flutter_live/ui/widgets/center_progress_indicator.dart';

import '../../data/models/network-response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import 'snackbar_message.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
    required this.onUpdateTask,
  });

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isLoading = false;
  bool isLoadingEdit = false;
  String dropdownValue = '';
  List<String> statusList = ['New', 'Completed', 'In Progress', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.taskModel.status ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text(
              'Due Date: ${widget.taskModel.createdDate}',
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
                  label: Text(widget.taskModel.status ?? 'New'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  backgroundColor: Colors.green[100],
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                SizedBox(width: 8),
                OverflowBar(
                  children: [
                    Visibility(
                      visible: isLoadingEdit == false,
                      replacement: CenterProgressIndicator(),
                      child: PopupMenuButton<String>(
                        icon: Icon(Icons.edit),
                        onSelected: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return statusList.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: ListTile(
                                title: Text(choice),
                                trailing:
                                    dropdownValue == choice
                                        ? Icon(Icons.check, color: Colors.green)
                                        : null,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),

                    Visibility(
                      visible: isLoading == false,
                      replacement: CenterProgressIndicator(),
                      child: IconButton(
                        onPressed: () {
                          _deleteTask();
                        },
                        icon: Icon(Icons.delete, color: Colors.blue, size: 20),
                      ),
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

  Future<void> _deleteTask() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.deleteTask(widget.taskModel.sId ?? ''),
    );
    if (response.isSuccess) {
      widget.onUpdateTask();
      showSnackBarMessage(context, 'Task deleted successfully');
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ??
              'Get task count by satus failed! Please try again',
        );
      }
    }
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }
}
