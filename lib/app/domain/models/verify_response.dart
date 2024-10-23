import 'dart:convert';

import 'user_model.dart';

class VerifyResponse {
  // final User? user;
  // final String? accessToken;
  final String? message;

  VerifyResponse({
    // required this.user,
    // required this.accessToken,
    this.message = '',
  });

  VerifyResponse copyWith({
    User? user,
    String? accessToken,
    String? message,
  }) =>
      VerifyResponse(
      //  user:user ?? this.user,
      //   accessToken: accessToken ?? this.accessToken,
        message: message ?? this.message,
      );

  factory VerifyResponse.fromJson(String str) =>
      VerifyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyResponse.fromMap(Map<String, dynamic> json) => VerifyResponse(
        // user: User.fromMap(json["user"]),
        // accessToken: json["access_token"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        // "user": user!.toMap(),
        // "access_token": accessToken,
        "message": message,
      };
}
