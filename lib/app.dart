import 'package:flutter/material.dart';
import 'package:flutter_live/ui/screen/tido_list/todo_list_screen.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListScreen(),
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.black,

          ),
        ),
      ),
    );
  }
}
