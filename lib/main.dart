import 'package:flutter/material.dart';
import 'package:flutter_task_tracker/screens/auth_screen.dart';
import 'package:flutter_task_tracker/services/auth_service.dart';
import 'package:flutter_task_tracker/theme/app_colors.dart';

void main() {
  runApp(const FlutterTaskTracker());
}

final authService = AuthService();

class FlutterTaskTracker extends StatelessWidget {
  const FlutterTaskTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task Tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
      home: const SessionGate(),
    );
  }
}
