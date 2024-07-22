import 'package:flutter/material.dart';
import '../models/recordatorio.dart';
import 'add_edit_recordatorio_screen.dart'; // Pantalla para añadir/editar recordatorios

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
  ];

  void _addOrEditRecordatorio([Recordatorio? recordatorio]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditRecordatorioScreen(recordatorio: recordatorio),
      ),
    );

    if (result != null) {
      setState(() {
        if (recordatorio == null) {
          _recordatorios.add(result);
        } else {
          final index = _recordatorios.indexOf(recordatorio);
          _recordatorios[index] = result;
        }
      });
    }
  }

  void _deleteRecordatorio(Recordatorio recordatorio) {
    setState(() {
      _recordatorios.remove(recordatorio);
    });
  }

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
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _addOrEditRecordatorio(_recordatorios[index]);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteRecordatorio(_recordatorios[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
