import 'dart:convert';

import 'user_model.dart';

class LoginResponse {
  final User user;
  final String accessToken;
  final String? message;

  LoginResponse({
    required this.user,
    required this.accessToken,
    this.message = '',
  });

  LoginResponse copyWith({
    User? user,
    String? accessToken,
    String? message,
  }) =>
      LoginResponse(
       user:user ?? this.user,
        accessToken: accessToken ?? this.accessToken,
        message: message ?? this.message,
      );

  factory LoginResponse.fromJson(String str) =>
      LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        user: User.fromMap(json["user"]),
        accessToken: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "access_token": accessToken,
        "message": message,
      };
}
