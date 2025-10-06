import 'package:flutter/material.dart';

import '../utility/app_colors.dart';
import '../widgets/network_cached_image.dart';
import '../widgets/profile_appbar.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'inprogress_task_screen.dart';
import 'new_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    NewTaskScreen(),
    CompletedTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (mounted) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task),
            label: 'New Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_bottom),
            label: 'In Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel_schedule_send),
            label: 'Canceled',
          ),
        ],
      ),
    );
  }
}

//22
