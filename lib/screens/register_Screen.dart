import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_repository.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserRepository _userRepository = UserRepository();
  String _username = '';
  String _email = '';
  String _password = '';

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      final user = User(
        username: _username.trim(),
        email: _email.trim(),
        password: _password.trim(),
      );
      await _userRepository.saveUser(user);

      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar el usuario: $e')),
      );
    }
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
              _buildTextField(
                label: 'Usuario',
                onSaved: (value) => _username = value!,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Correo electrónico',
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20),
              _buildPasswordField(
                label: 'Contraseña',
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _registerUser();
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

  TextFormField _buildTextField({
    required String label,
    required void Function(String?) onSaved,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }

  TextFormField _buildPasswordField({
    required String label,
    required void Function(String?) onSaved,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: validator,
      onSaved: onSaved,
    );
  }
}

