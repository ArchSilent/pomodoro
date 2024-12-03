import 'package:flutter/material.dart';
import 'package:pomotoro/screens/splash_screen.dart'; // Asegúrate de importar SplashScreen
import 'package:provider/provider.dart';
import 'screens/pomodoro_timer.dart'; // Importa el PomodoroTimer

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          PomodoroTimer(), // Proveedor del temporizador en el nivel raíz
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomotoro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE7626C)),
        useMaterial3: true,
      ),
      home:
          const SplashScreen(), // Asegúrate de que la pantalla inicial sea la SplashScreen
    );
  }
}
