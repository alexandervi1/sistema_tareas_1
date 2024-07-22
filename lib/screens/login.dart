import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Clave global para el formulario que permite validar y guardar el estado
  final _formKey = GlobalKey<FormState>();

  // Variables para almacenar los datos ingresados por el usuario
  String _email = '';
  String _password = '';

  // Método para validar las credenciales del usuario
  Future<bool> _validateUser() async {
    // Obtén el directorio de documentos de la aplicación
    final directory = await getApplicationDocumentsDirectory();
    // Crea una instancia del archivo JSON con la ruta del directorio
    final file = File('${directory.path}/usuarios.json');

    // Verifica si el archivo existe
    if (await file.exists()) {
      // Lee el contenido del archivo como una cadena
      final contents = await file.readAsString();
      // Decodifica el contenido del archivo JSON
      final users = jsonDecode(contents);

      // Verifica si el contenido es un mapa de datos
      if (users is Map<String, dynamic>) {
        // Itera sobre los usuarios y verifica si el correo y la contraseña coinciden
        for (var user in users.values) {
          if (user['email'] == _email && user['password'] == _password) {
            return true; // Las credenciales son válidas
          }
        }
      }
    }
    return false; // Las credenciales no son válidas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para ingresar el correo electrónico
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Valida si el valor ingresado no es nulo o vacío
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un correo electrónico';
                  }
                  // Valida el formato del correo electrónico
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Ingrese un correo electrónico válido';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20),
              // Campo para ingresar la contraseña
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  // Valida si el valor ingresado no es nulo o vacío
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              // Botón para iniciar sesión
              ElevatedButton(
                onPressed: () async {
                  // Verifica si el formulario es válido
                  if (_formKey.currentState!.validate()) {
                    // Guarda el estado del formulario
                    _formKey.currentState!.save();

                    // Verifica las credenciales del usuario
                    bool isValid = await _validateUser();
                    if (isValid) {
                      // Si las credenciales son válidas, navega a la pantalla de tareas
                      Navigator.pushReplacementNamed(context, '/tareas');
                    } else {
                      // Muestra un mensaje de error si las credenciales no son válidas
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Credenciales inválidas'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 20),
              // Botón para navegar a la pantalla de registro
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registro');
                },
                child: const Text('¿No tienes cuenta? Regístrate'),
              ),
              const SizedBox(height: 20),
              // Botón para navegar a la pantalla de recuperación de contraseña
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/recuperacion'); // Ruta para la recuperación de contraseña
                },
                child: const Text('¿Olvidaste tu contraseña?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

