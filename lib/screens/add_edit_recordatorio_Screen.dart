import 'package:flutter/material.dart';
import '../models/recordatorio.dart';

class AddEditRecordatorioScreen extends StatefulWidget {
  final Recordatorio? recordatorio;

  const AddEditRecordatorioScreen({super.key, this.recordatorio});

  @override
  _AddEditRecordatorioScreenState createState() => _AddEditRecordatorioScreenState();
}

class _AddEditRecordatorioScreenState extends State<AddEditRecordatorioScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _titulo;
  late DateTime _fecha;
  late TimeOfDay _hora;

  @override
  void initState() {
    super.initState();
    if (widget.recordatorio != null) {
      _titulo = widget.recordatorio!.titulo;
      _fecha = widget.recordatorio!.fecha;
      _hora = widget.recordatorio!.hora;
    } else {
      _titulo = '';
      _fecha = DateTime.now();
      _hora = TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recordatorio == null ? 'Añadir Recordatorio' : 'Editar Recordatorio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _titulo,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
                onSaved: (value) => _titulo = value!,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text('Fecha: ${_fecha.day}/${_fecha.month}/${_fecha.year}'),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _fecha,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _fecha) {
                    setState(() {
                      _fecha = pickedDate;
                    });
                  }
                },
              ),
              ListTile(
                title: Text('Hora: ${_hora.hour}:${_hora.minute}'),
                onTap: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _hora,
                  );
                  if (pickedTime != null && pickedTime != _hora) {
                    setState(() {
                      _hora = pickedTime;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final recordatorio = Recordatorio(
                      titulo: _titulo,
                      fecha: _fecha,
                      hora: _hora,
                    );
                    Navigator.pop(context, recordatorio);
                  }
                },
                child: Text(widget.recordatorio == null ? 'Añadir' : 'Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
