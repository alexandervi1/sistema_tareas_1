// lib/models/nota.dart
import 'package:json_annotation/json_annotation.dart';

part 'nota.g.dart'; // Parte del archivo generado automáticamente por build_runner

@JsonSerializable()
class Nota {
  final String nota;
  final String opcionSeleccionada;

  Nota({
    required this.nota,
    required this.opcionSeleccionada,
  });

  factory Nota.fromJson(Map<String, dynamic> json) => _$NotaFromJson(json);

  Map<String, dynamic> toJson() => _$NotaToJson(this);
}
