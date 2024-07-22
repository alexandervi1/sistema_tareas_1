import 'package:flutter/material.dart';

class NotasScreen extends StatefulWidget {
  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nota = '';
  String _opcionSeleccionada = 'Opción 1';

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
              RadioListTile(
                title: Text('Opción 1'),
                value: 'Opción 1',
                groupValue: _opcionSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionSeleccionada = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text('Opción 2'),
                value: 'Opción 2',
                groupValue: _opcionSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionSeleccionada = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text('Opción 3'),
                value: 'Opción 3',
                groupValue: _opcionSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionSeleccionada = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes guardar la nota y la opción seleccionada en una base de datos o realizar otra acción
                    print('Nota: $_nota, Opción: $_opcionSeleccionada');
                  }
                },
                child: Text('Crear Nota'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}