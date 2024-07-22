import 'package:json_annotation/json_annotation.dart';

// Indica que el archivo generado es parte de este archivo
part 'user.g.dart';

@JsonSerializable()
class User {
  final String username;
  final String email;
  final String password;

  User({
    required this.username,
    required this.email,
    required this.password,
  });

  // Factory constructor para crear una nueva instancia de User desde un mapa
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Método para convertir la instancia de User a un mapa
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
