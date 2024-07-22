import 'package:flutter/material.dart';
import 'recordatorios_screen.dart'; // Asegúrate de importar la pantalla de recordatorios
import 'tareas_screen.dart'; // Importa también otras pantallas si es necesario
import 'notas_Screen.dart'; // Si tienes una pantalla de notas

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
      ),
      body: Center(
        child: const Text('Bienvenido a la pantalla principal'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              MediaQuery.of(context).size.width - 70,
              MediaQuery.of(context).size.height - 70,
              0,
              0,
            ),
            items: [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.note),
                  title: Text('Añadir Nota'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotasScreen()),
                    );
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text('Añadir Tarea'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TareasScreen()),
                    );
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.alarm),
                  title: Text('Añadir Recordatorio'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordatoriosScreen()),
                    );
                  },
                ),
              ),
            ],
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

