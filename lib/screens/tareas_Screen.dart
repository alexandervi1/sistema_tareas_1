import 'package:flutter/material.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});

  @override
  _TareasScreenState createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas'),
      ),
      body: Center(
        child: const Text('Pantalla de tareas'),
      ),
    );
  }
}
