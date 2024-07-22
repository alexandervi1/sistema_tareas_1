import 'package:flutter/material.dart';
import '../models/user.dart'; // Verifica que este archivo exista y esté bien implementado
import '../services/user_repository.dart'; // Verifica que este archivo exista y esté bien implementado

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserRepository _userRepository = UserRepository(); // Verifica la implementación de esta clase
  String _username = '';
  String _password = '';

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      final user = await _userRepository.getUser(_username.trim());
      if (user != null && user.password == _password.trim()) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario o contraseña incorrectos')),
        );
      }
    } catch (e) {
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
              ElevatedButton(
                onPressed: _loginUser,
                child: const Text('Iniciar Sesión'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('¿No tienes una cuenta? Regístrate'),
              ),
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
