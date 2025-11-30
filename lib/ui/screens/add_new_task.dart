import 'package:flutter/material.dart';
import 'package:flutter_live/ui/widgets/background_widget.dart';
import 'package:flutter_live/ui/widgets/profile_appbar.dart';

import '../../data/models/network-response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/center_progress_indicator.dart';
import '../widgets/snackbar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _textController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,

      child: Scaffold(
        appBar: profileAppBar(context),
        body: BackgroundWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Task Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Task title is required';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Task Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Task description is required';
                        }
                        return null;
                      },
                      maxLines: 4,
                    ),
                    SizedBox(height: 20),
                    Visibility(
                      visible: _isLoading == false,
                      replacement: CenterProgressIndicator(),

                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveTask();
                          }
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save Task',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestData = {
      "title": _textController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New",
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createTask,
      body: requestData,
    );

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      _clearForm();
      if (mounted) {
        showSnackBarMessage(context, 'Task created successfully');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Failed to create task',
          true,
        );
      }
    }
  }

  void _clearForm() {
    _textController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _textController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

//30
