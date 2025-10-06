import 'package:flutter/material.dart';
import 'package:flutter_live/ui/widgets/background_widget.dart';
import 'package:flutter_live/ui/widgets/profile_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _textController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: profileAppBar(context),
        body: BackgroundWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Task Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Logic to save the new task
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
