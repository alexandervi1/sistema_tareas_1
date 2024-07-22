import 'package:flutter/material.dart';

class RecordatoriosScreen extends StatefulWidget {
  @override
  _RecordatoriosScreenState createState() => _RecordatoriosScreenState();
}

class _RecordatoriosScreenState extends State<RecordatoriosScreen> {
  List<Recordatorio> _recordatorios = [
    Recordatorio(
      titulo: 'Recordatorio 1',
      fecha: DateTime.now(),
      hora: TimeOfDay(hour: 10, minute: 30),
    ),
    Recordatorio(
      titulo: 'Recordatorio 2',
      fecha: DateTime.now().add(Duration(days: 1)),
      hora: TimeOfDay(hour: 14, minute: 45),
    ),
    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      body: ListView.builder(
        itemCount: _recordatorios.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_recordatorios[index].titulo),
              subtitle: Text(
                '${_recordatorios[index].fecha.day}/${_recordatorios[index].fecha.month}/${_recordatorios[index].fecha.year} ${_recordatorios[index].hora.hour}:${_recordatorios[index].hora.minute}',
              ),
              trailing: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Editar recordatorio
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Eliminar recordatorio
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Crear nuevo recordatorio
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Recordatorio {
  String titulo;
  DateTime fecha;
  TimeOfDay hora;

  Recordatorio({required this.titulo, required this.fecha, required this.hora});
}