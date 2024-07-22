// lib/services/nota_repository.dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/nota.dart';

class NotaRepository {
  Future<File> _getNotaFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/notas.json');
  }

  Future<List<Nota>> _readNotas() async {
    final file = await _getNotaFile();
    if (await file.exists()) {
      try {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(contents);
        return jsonList.map((json) => Nota.fromJson(json as Map<String, dynamic>)).toList();
      } catch (e) {
        print('Error leyendo o parseando notas: $e');
        return [];
      }
    }
    return [];
  }

  Future<void> saveNota(Nota nota) async {
    try {
      final notas = await _readNotas();
      notas.add(nota);
      final file = await _getNotaFile();
      await file.writeAsString(jsonEncode(notas.map((n) => n.toJson()).toList()));
    } catch (e) {
      print('Error guardando nota: $e');
    }
  }
}
