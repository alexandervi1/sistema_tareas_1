import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  Future<void> _registerUser() async {
    // Verifica si las contraseñas coinciden
    if (_password != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    // Obtén el directorio de documentos de la aplicación
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/usuarios.json');

    Map<String, dynamic> users = {};

    // Verifica si el archivo existe
    if (await file.exists()) {
      final contents = await file.readAsString();
      users = jsonDecode(contents);
    }

    // Agrega el nuevo usuario
    users[_username] = {
      'email': _email,
      'password': _password,
    };

    // Guarda el archivo actualizado
    await file.writeAsString(jsonEncode(users));

    // Navega a la pantalla de login
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un usuario';
                  }
                  return null;
                },
                onSaved: (value) => _username = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un correo electrónico';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmar contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la contraseña nuevamente';
                  }
                  if (value != _password) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
                onSaved: (value) => _confirmPassword = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _registerUser(); // Llama al método para registrar al usuario
                  }
                },
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
