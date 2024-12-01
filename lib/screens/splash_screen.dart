import 'package:flutter/material.dart';
import 'package:pomotoro/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navegar a la pantalla principal después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFE7626C), // Fondo rojo pastel
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Centra los elementos
          children: [
            // Primero el texto
            const Text(
              'pomotoro',
              style: TextStyle(
                fontSize: 40, // Ajusta el tamaño de la fuente
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30), // Espacio entre el texto y la imagen
            // Luego la imagen del personaje
            Image.asset(
              'assets/images/totoro.png', // Ruta de tu imagen
              height: 200, // Ajusta el tamaño de la imagen
            ),
          ],
        ),
      ),
    );
  }
}
