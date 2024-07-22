import 'package:flutter/material.dart';

class Recordatorio {
  String titulo;
  DateTime fecha;
  TimeOfDay hora;

  Recordatorio({required this.titulo, required this.fecha, required this.hora});
}
