import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String timerText = '25:00';

  void updateTimer(int tabIndex) {
    setState(() {
      if (tabIndex == 0) {
        timerText = '25:00'; // Pomotoro
      } else if (tabIndex == 1) {
        timerText = '5:00'; // Descanso
      } else if (tabIndex == 2) {
        timerText = '15:00'; // Largo Descanso
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFE7626C),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título y logo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'pomotor',
                  style: const TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  "assets/images/totoroicon.png",
                  height: 35,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TabBar sin línea divisoria
            TabBar(
              onTap: updateTimer,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'Pomotoro'),
                Tab(text: 'Descanso'),
                Tab(text: 'Largo Descanso'),
              ],
            ),
            const SizedBox(height: 40),

            // Temporizador
            Text(
              timerText,
              style: const TextStyle(
                fontFamily: "Montserrat",
                fontSize: 80,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Botón de reproducción
            IconButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para iniciar el temporizador
              },
              icon: const Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
