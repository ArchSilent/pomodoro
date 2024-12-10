import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pomodoro_timer.dart';
import '../models/task_provider.dart';

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

    updateTimer(0);
  }

  void updateTimer(int tabIndex) {
    if (tabIndex == 0) {
      context.read<PomodoroTimer>().updateTime(25, 0);
    } else if (tabIndex == 1) {
      context.read<PomodoroTimer>().updateTime(5, 0);
    } else if (tabIndex == 2) {
      context.read<PomodoroTimer>().updateTime(15, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7626C),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sección de botones, título y TabBar (igual que antes)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCustomButton(
                  icon: Icons.bar_chart,
                  text: 'Report',
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
                _buildCustomButton(
                  icon: Icons.settings,
                  text: 'Setting',
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
                _buildCustomButton(
                  icon: Icons.person,
                  text: 'Sign In',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            const SizedBox(height: 40),

            // Lista de tareas
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lista de tareas',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<TaskProvider>(
                    builder: (context, taskProvider, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: taskProvider.tasks.length,
                        itemBuilder: (context, index) {
                          final task = taskProvider.tasks[index];
                          return ListTile(
                            leading: Checkbox(
                              value: task.isDone,
                              onChanged: (value) {
                                taskProvider.toggleTask(index);
                              },
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    task.isDone ? Colors.white70 : Colors.white,
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon:
                                  const Icon(Icons.delete, color: Colors.white),
                              onPressed: () {
                                taskProvider.deleteTask(index);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddTaskDialog(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar tarea'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nueva tarea'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Ingrese la tarea'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  // Agregar la tarea al TaskProvider
                  context.read<TaskProvider>().addTask(taskController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildCustomButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Icon(icon),
      label: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
