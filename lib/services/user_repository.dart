import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

class UserRepository {
  Future<File> _getUserFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/usuarios.json');
  }

  Future<User?> getUser(String username) async {
    final file = await _getUserFile();
    if (await file.exists()) {
      try {
        final contents = await file.readAsString();
        final Map<String, dynamic> jsonMap = jsonDecode(contents);
        final userJson = jsonMap[username];
        if (userJson != null) {
          return User.fromJson(userJson as Map<String, dynamic>);
        }
      } catch (e) {
        print('Error leyendo usuarios: $e');
      }
    }
    return null;
  }

  Future<void> saveUser(User user) async {
    try {
      final users = await _readUsers();
      users[user.username] = user.toJson();
      final file = await _getUserFile();
      await file.writeAsString(jsonEncode(users));
    } catch (e) {
      print('Error guardando usuario: $e');
    }
  }

  Future<Map<String, dynamic>> _readUsers() async {
    final file = await _getUserFile();
    if (await file.exists()) {
      try {
        final contents = await file.readAsString();
        return jsonDecode(contents) as Map<String, dynamic>;
      } catch (e) {
        print('Error leyendo usuarios: $e');
      }
    }
    return {};
  }
}

