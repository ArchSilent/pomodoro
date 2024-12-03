import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pomodoro_timer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        updateTimer(_tabController.index);
      }
    });

    // Inicializa el temporizador en la pestaña "Pomodoro" (25 minutos)
    updateTimer(0);
  }

  void updateTimer(int tabIndex) {
    if (tabIndex == 0) {
      context.read<PomodoroTimer>().updateTime(25, 0); // Pomodoro: 25 minutos
    } else if (tabIndex == 1) {
      context.read<PomodoroTimer>().updateTime(5, 0); // Descanso: 5 minutos
    } else if (tabIndex == 2) {
      context
          .read<PomodoroTimer>()
          .updateTime(15, 0); // Descanso Largo: 15 minutos
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7626C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pomotoro',
                style: TextStyle(
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
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: 'Pomodoro'),
              Tab(text: 'Descanso'),
              Tab(text: 'Largo Descanso'),
            ],
          ),
          const SizedBox(height: 40),
          Consumer<PomodoroTimer>(
            builder: (context, timer, child) => Text(
              timer.timeFormatted,
              style: const TextStyle(
                fontFamily: "Montserrat",
                fontSize: 150,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Fila de botones: Play y Reset
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón para iniciar o detener el temporizador
              IconButton(
                onPressed: () {
                  context.read<PomodoroTimer>().startFromRemaining();
                },
                icon: Consumer<PomodoroTimer>(
                  builder: (context, timer, child) {
                    return Icon(
                      timer.isRunning
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 80,
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              // Botón para reiniciar el temporizador
              IconButton(
                onPressed: () {
                  context.read<PomodoroTimer>().reset();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
