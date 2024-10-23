import 'dart:convert';

import 'user_model.dart';

class RegisterResponse {
  //  final User? user;
  //  final String? accessToken;
  final String? message;

  RegisterResponse({
    // this.user,
    // this.accessToken,
    this.message = '',
  });

  RegisterResponse copyWith({
    User? user,
    String? accessToken,
    String? message,
  }) =>
      RegisterResponse(
        // user:user ?? this.user,
        // accessToken: accessToken ?? this.accessToken,
        message: message ?? this.message,
      );

  factory RegisterResponse.fromJson(String str) =>
      RegisterResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponse.fromMap(Map<String, dynamic> json) => RegisterResponse(
        // user: User.fromMap(json["user"]),
        // accessToken: json["access_token"],
        message: json["message"][0],
      );

  Map<String, dynamic> toMap() => {
        // "user": user!.toMap(),
        // "access_token": accessToken,
        "message": message,
      };
}
