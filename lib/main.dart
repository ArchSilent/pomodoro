import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart'; // Importa HomeScreen
import 'models/task_provider.dart'; // Importa TaskProvider
import 'screens/pomodoro_timer.dart'; // Importa PomodoroTimer

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PomodoroTimer()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
