import 'dart:io';

import 'package:equatable/equatable.dart';

class UserProfileBody extends Equatable {
  final String? name;
  final String? password;
  final String? gender;
  final DateTime? birthDate;
  final String? birthPlace;
  final String? biography;
  final String? address;
  final String? idType;
  final String? identification;
  final String? phone;
  final File? file;

  const UserProfileBody({
    this.name,
    this.password,
    this.gender,
    this.birthDate,
    this.birthPlace,
    this.biography,
    this.address,
    this.idType,
    this.identification,
    this.phone,
    this.file,
  });

  // factory UserProfileBody.fromJson(Map<String, dynamic> json) {
  //   return UserProfileBody(
  //     name: json['name'],
  //     password: json['password'],
  //     gender: json['gender'],
  //     birthDate: DateTime.tryParse(json['birth_date']),
  //     birthPlace: json['birth_place'],
  //     biography: json['biography'],
  //     address: json['address'],
  //     idType: json['id_type'],
  //     identification: json['identification'],
  //     phone: json['phone'],
  //     // El campo "file" no se puede asignar directamente desde el JSON, ya que es de tipo File.
  //     // Debes manejarlo por separado al utilizar el método fromJson().
  //   );
  // }

  Map<String, String> toMap() {
    return {
      if (name != null) 'name': name!,
      if (password != null) 'password': password!,
      if (gender != null) 'gender': gender!,
      if (birthDate != null) 'birth_date': birthDate!.toIso8601String(),
      if (birthPlace != null) 'birth_place': birthPlace!,
      if (biography != null) 'biography': biography!,
      if (address != null) 'address': address!,
      if (idType != null) 'id_type': idType!,
      if (identification != null) 'identification': identification!,
      if (phone != null) 'phone': phone!,
    };
  }

  UserProfileBody copyWith({
    String? name,
    String? password,
    String? gender,
    DateTime? birthDate,
    String? birthPlace,
    String? biography,
    String? address,
    String? idType,
    String? identification,
    String? phone,
    File? file,
  }) {
    return UserProfileBody(
      name: name ?? this.name,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      birthPlace: birthPlace ?? this.birthPlace,
      biography: biography ?? this.biography,
      address: address ?? this.address,
      idType: idType ?? this.idType,
      identification: identification ?? this.identification,
      phone: phone ?? this.phone,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [
        name,
        password,
        gender,
        birthDate,
        birthPlace,
        biography,
        address,
        idType,
        identification,
        phone,
        file,
      ];
}
