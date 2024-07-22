import 'package:flutter/material.dart';

class RecuperacionContrasenaScreen extends StatefulWidget {
  const RecuperacionContrasenaScreen({super.key});

  @override
  _RecuperacionContrasenaScreenState createState() => _RecuperacionContrasenaScreenState();
}

class _RecuperacionContrasenaScreenState extends State<RecuperacionContrasenaScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Ingrese un correo electrónico válido';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí se debería implementar la lógica para enviar un correo de recuperación
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Correo de recuperación enviado'),
                      ),
                    );
                    // Navega a la pantalla de login después de enviar el correo
                    Navigator.pop(context);
                  }
                },
                child: const Text('Recuperar contraseña'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

