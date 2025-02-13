import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  /// Converts a JSON Map into an instance of User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts this instance into a JSON Map.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
  