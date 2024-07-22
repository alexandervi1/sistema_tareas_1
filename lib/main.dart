import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_Screen.dart'; // Asegúrate de que este archivo exista
import 'screens/recuperacioncontrasena_screen.dart';
import 'screens/recordatorios_screen.dart';
import 'screens/tareas_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp()); // Elimina `const` si el constructor no es `const`
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema Tareas Espoch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 198, 207, 65),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/tareas': (context) => TareasScreen(),
        '/register': (context) => RegistroScreen(),
        '/recuperacion': (context) => RecuperacionContrasenaScreen(),
        '/home': (context) => HomeScreen(),
        '/recordatorios': (context) => RecordatoriosScreen(),
      },
    );
  }
}
