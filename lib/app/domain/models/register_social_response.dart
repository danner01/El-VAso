import 'dart:convert';

import 'user_model.dart';

class RegisterSocialResponse {
   final User? user;
   final String? accessToken;
  final String? message;

  RegisterSocialResponse({
    this.user,
    this.accessToken,
    this.message = '',
  });

  RegisterSocialResponse copyWith({
    User? user,
    String? accessToken,
    String? message,
  }) =>
      RegisterSocialResponse(
        user:user ?? this.user,
        accessToken: accessToken ?? this.accessToken,
        message: message ?? this.message,
      );

  factory RegisterSocialResponse.fromJson(String str) =>
      RegisterSocialResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterSocialResponse.fromMap(Map<String, dynamic> json) => RegisterSocialResponse(
        user: User.fromMap(json["user"]),
        accessToken: json["token"],
        message: json["message"]!=null?json["message"][0]:'',
      );

  Map<String, dynamic> toMap() => {
        "user": user!.toMap(),
        "access_token": accessToken,
        "message": message,
      };
}
