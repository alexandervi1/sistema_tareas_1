import 'package:flutter/material.dart';
import 'package:sistema_tareas_1/screens/tareas.dart';
import 'package:sistema_tareas_1/screens/login.dart';
import 'package:sistema_tareas_1/screens/register.dart';

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
        '/': (context) => const LoginScreen(),
        '/tareas': (context) => const TareasScreen(),
        '/registro': (context) => const RegistroScreen(),
      },
    );
  }
}
