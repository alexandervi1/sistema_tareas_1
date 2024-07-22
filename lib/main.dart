import 'package:flutter/material.dart';
import 'package:sistema_tareas_1/screens/login.dart';
import 'package:sistema_tareas_1/screens/recuperacioncontrasena.dart'; // Importar la pantalla de recuperación de contraseña
import 'package:sistema_tareas_1/screens/register.dart';
import 'package:sistema_tareas_1/screens/tareas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema tareas Espoch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 198, 207, 65),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(), // Ruta para la pantalla de inicio de sesión
        '/tareas': (context) => const TareasScreen(), // Ruta para la pantalla de tareas
        '/registro': (context) => const RegistroScreen(), // Ruta para la pantalla de registro
        '/recuperacion': (context) => const RecuperacionContrasenaScreen(), // Ruta para la pantalla de recuperación de contraseña
      },
    );
  }
}
