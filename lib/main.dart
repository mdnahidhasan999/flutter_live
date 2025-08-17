import 'package:flutter/material.dart';
import 'package:flutter_live/home_screen.dart';

void main() {
  runApp(WaterTrakerApp());
}

class WaterTrakerApp extends StatelessWidget {
  const WaterTrakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
