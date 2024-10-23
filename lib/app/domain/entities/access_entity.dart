// To parse this JSON data, do
//
//     final access = accessFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Access extends Equatable {
  final String? user;
  final String? property;
  final String? rol;
  final DateTime? endDate;

  const Access({
    this.user,
    this.property,
    this.rol,
    this.endDate,
  });

  Access copyWith({
    String? user,
    String? property,
    String? rol,
    DateTime? endDate,
  }) =>
      Access(
        user: user ?? this.user,
        property: property ?? this.property,
        rol: rol ?? this.rol,
        endDate: endDate ?? this.endDate,
      );

  factory Access.fromJson(String str) => Access.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Access.fromMap(Map<String, dynamic> json) => Access(
        user: json["user"],
        property: json["property"],
        rol: json["rol"],
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toMap() => {
        "user": user,
        "property": property,
        "rol": rol,
        "end_date": endDate!.toIso8601String(),
      };

  @override
  List<Object?> get props => [user, property, rol, endDate];
}
