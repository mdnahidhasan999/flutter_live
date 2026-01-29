import 'package:flutter_live/data/models/task_count_status.dart';

class TaskCountModel {
  String? status;
  List<TaskCountStatus>? taskCountStatusList;

  TaskCountModel({this.status, this.taskCountStatusList});

  TaskCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountStatusList = <TaskCountStatus>[];
      json['data'].forEach((v) {
        taskCountStatusList!.add(TaskCountStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskCountStatusList != null) {
      data['data'] = taskCountStatusList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


