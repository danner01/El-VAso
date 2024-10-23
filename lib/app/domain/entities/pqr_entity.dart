import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'property_entity.dart';
import 'unity_entity.dart';

List<PQR> pqrFromMap(String str) =>
    List<PQR>.from(json.decode(str).map((x) => PQR.fromMap(x)));

String pqrToMap(List<PQR> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class PQR extends Equatable {
  final Unity? unity;
  final Property? property;
  final String? category;
  final String? type;
  final DateTime? dateNeeded;
  final String? description;
  final bool active;
  final String? state;
  final String? id;
  final DateTime? createdDate;

  const PQR({
    this.unity,
    this.property,
    this.category,
    this.type,
    this.dateNeeded,
    this.description,
    this.active = false,
    this.state,
    this.id,
    required this.createdDate,
  });

  PQR copyWith({
    Unity? unity,
    Property? property,
    String? category,
    String? type,
    DateTime? dateNeeded,
    String? description,
    bool? active,
    String? state,
    DateTime? createdDate,
  }) =>
      PQR(
        unity: unity ?? this.unity,
        property: property ?? this.property,
        category: category ?? this.category,
        type: type ?? this.type,
        dateNeeded: dateNeeded ?? this.dateNeeded,
        description: description ?? this.description,
        active: active ?? this.active,
        state: state ?? this.state,
        createdDate: createdDate ?? this.createdDate,
      );

  String toJson() => json.encode(toMap());

  factory PQR.fromMap(Map<String, dynamic> json) {
    log('propery typeof: ${json["property"].runtimeType}');
    return PQR(
      unity: null, // Unity.fromJson(json["unity"]),
      property:
          json["property"] != null ? Property.fromMap(json["property"]) : null,
      category: json["category"],
      type: json["type"],
      dateNeeded: json["date_needed"] == null
          ? DateTime.now()
          : DateTime.parse(json["date_needed"]),
      description: json["description"],
      state: json["state"],
      active: json["active"],
      id: json["_id"],
      createdDate: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "unity": unity?.id,
        "property": property?.id,
        "category": category,
        "type": type,
        "date_needed": dateNeeded!.toIso8601String(),
        "description": description,
        // "active": active,
        // "state": state,
      };

  @override
  List<Object?> get props => [
        unity,
        property,
        category,
        type,
        dateNeeded,
        description,
        state,
        active,
        createdDate,
      ];
}

class PQRBody extends Equatable {
  final String? unity;
  final String? property;
  final String? category;
  final String? type;
  final DateTime? dateNeeded;
  final String? description;
  final bool active;
  final String? state;

  const PQRBody({
    this.unity,
    this.property,
    this.category,
    this.type,
    this.dateNeeded,
    this.description,
    this.active = false,
    this.state,
  });

  PQRBody copyWith({
    String? unity,
    String? property,
    String? category,
    String? type,
    DateTime? dateNeeded,
    String? description,
    bool? active,
    String? state,
  }) =>
      PQRBody(
        unity: unity ?? this.unity,
        property: property ?? this.property,
        category: category ?? this.category,
        type: type ?? this.type,
        dateNeeded: dateNeeded ?? this.dateNeeded,
        description: description ?? this.description,
        active: active ?? this.active,
        state: state ?? this.state,
      );
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "unity": unity,
        "property": property,
        "category": category,
        "type": type,
        "date_needed": dateNeeded!.toIso8601String(),
        "description": description,
        // "active": active,
        // "state": state,
      };

  @override
  List<Object?> get props => [
        unity,
        property,
        category,
        type,
        dateNeeded,
        description,
        state,
        active,
      ];
}
