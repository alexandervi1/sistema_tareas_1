import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart'; // Archivo generado por json_serializable

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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

