// lib/screens/notas_screen.dart
import 'package:flutter/material.dart';
import '../models/nota.dart';
import '../services/nota_repository.dart';

class NotasScreen extends StatefulWidget {
  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final _formKey = GlobalKey<FormState>();
  final NotaRepository _notaRepository = NotaRepository();
  String _nota = '';
  String _opcionSeleccionada = 'Opción 1';

  Future<void> _crearNota() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final nuevaNota = Nota(
        nota: _nota.trim(),
        opcionSeleccionada: _opcionSeleccionada,
      );
      await _notaRepository.saveNota(nuevaNota);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nota creada con éxito')),
      );

      // Limpiar el formulario
      _formKey.currentState!.reset();
      setState(() {
        _opcionSeleccionada = 'Opción 1';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nota',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una nota';
                  }
                  return null;
                },
                onSaved: (value) => _nota = value!,
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: _opcionSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionSeleccionada = value!;
                  });
                },
                items: [
                  'Opción 1',
                  'Opción 2',
                  'Opción 3',
                ].map((e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _crearNota,
                child: Text('Crear Nota'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
