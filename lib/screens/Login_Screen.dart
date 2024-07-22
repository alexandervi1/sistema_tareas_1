import 'package:flutter/material.dart';

import '../services/user_repository.dart'; // Verifica que este archivo exista y esté bien implementado

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Llave global para el formulario
  final UserRepository _userRepository = UserRepository(); // Instancia del repositorio de usuarios
  String _username = ''; // Variable para almacenar el nombre de usuario
  String _password = ''; // Variable para almacenar la contraseña

  // Función para iniciar sesión
  Future<void> _loginUser() async {
    // Verificar si el formulario es válido
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save(); // Guardar los valores del formulario

    try {
      // Buscar el usuario en el repositorio
      final user = await _userRepository.getUser(_username.trim());
      // Verificar si el usuario existe y la contraseña es correcta
      if (user != null && user.password == _password.trim()) {
        // Navegar a la pantalla principal
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario o contraseña incorrectos')),
        );
      }
    } catch (e) {
      // Mostrar mensaje de error en caso de excepción
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de texto para el nombre de usuario
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Validación del campo de usuario
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un usuario';
                  }
                  return null;
                },
                onSaved: (value) => _username = value!, // Guardar el valor ingresado
              ),
              const SizedBox(height: 20),
              // Campo de texto para la contraseña
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Ocultar texto para la contraseña
                validator: (value) {
                  // Validación del campo de contraseña
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!, // Guardar el valor ingresado
              ),
              const SizedBox(height: 20),
              // Botón para iniciar sesión
              ElevatedButton(
                onPressed: _loginUser,
                child: const Text('Iniciar Sesión'),
              ),
              // Botón para navegar a la pantalla de registro
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('¿No tienes una cuenta? Regístrate'),
              ),
              // Botón para navegar a la pantalla de recuperación de contraseña
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/recuperacion');
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
