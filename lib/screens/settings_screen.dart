import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pomodoro_timer.dart';
import './home_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pomodoroTimer = context.watch<PomodoroTimer>();
    final TextEditingController pomodoroController =
        TextEditingController(text: pomodoroTimer.initialMinutes.toString());
    final TextEditingController shortBreakController =
        TextEditingController(text: "5"); // Valor predeterminado
    final TextEditingController longBreakController =
        TextEditingController(text: "15"); // Valor predeterminado

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Temporizador'),
        backgroundColor: const Color(0xFFE7626C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajustes de Temporizador',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingRow(
              context: context,
              label: 'Duración Pomodoro (min):',
              controller: pomodoroController,
            ),
            _buildSettingRow(
              context: context,
              label: 'Descanso Corto (min):',
              controller: shortBreakController,
            ),
            _buildSettingRow(
              context: context,
              label: 'Descanso Largo (min):',
              controller: longBreakController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Guardar los valores actualizados
                pomodoroTimer.updateTime(
                  int.tryParse(pomodoroController.text) ?? 25,
                  0,
                );
                // Aquí puedes usar el mismo provider para los descansos
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE7626C),
              ),
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
