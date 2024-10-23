import 'dart:convert';

import 'user_model.dart';

class UserResponse {
  final User user;
  final int properties;

  UserResponse({
    required this.user,
    required this.properties,
  });

  UserResponse copyWith({
    User? user,
    int? properties,
  }) =>
      UserResponse(
        user: user ?? this.user,
        properties: properties ?? this.properties,
      );

  factory UserResponse.fromJson(String str) =>
      UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        user: User.fromMap(json["user"]),
        properties: json["properties"],
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "properties": properties,
      };
}
