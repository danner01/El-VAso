// ignore: must_be_immutable
import 'dart:convert';
import 'dart:developer';

import 'package:bcrypt/bcrypt.dart';
import 'package:el_vaso/app/config/injection/injection.dart';
import 'package:el_vaso/app/config/local_storage/local_storage.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  // final String? id;
  final String email;
  final String? password;
  final String? name;
  final String? lastname;
  final String? username;
  final String? avatar;
  final DateTime? birthdate;
  final String? gender;
  final String? postalCode;
  final String? dniNumber;
  final String? passportNumber;
  final String? phoneNumber;
  final List<String>? roles;

  const User({
    // this.id,
    required this.email,
    this.password,
    this.name,
    this.lastname,
    this.username,
    this.birthdate,
    this.gender,
    this.avatar,
    this.postalCode,
    this.dniNumber,
    this.passportNumber,
    this.phoneNumber,
    this.roles,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'email': email,
      'password': password,
      'name': name,
      'lastname': lastname,
      'username': username ?? '',
      'birthdate': birthdate?.toIso8601String(),
      'gender': gender ?? '',
      'avatar': avatar ?? '',
      'postalCode': postalCode ?? '',
      'dniNumber': dniNumber ?? '',
      'passportNumber': passportNumber ?? '',
      'phoneNumber': phoneNumber,
      'roles': roles ?? [],
    };
  }

  factory User.fromJson(String str) => User.fromMap(json.decode(str));
  factory User.empty() => emptyUser;

  factory User.getUserLocal() {
    try {
      final localStorage = getIt.get<LocalStorage>();
      Map<String, dynamic> jsonData = json.decode(localStorage.user);

      final localUser = User.fromMap(jsonData);
      log('Local:$localUser');
      return localUser;
    } catch (e) {
      return User.empty();
    }
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      // id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
      lastname: map['lastname'],
      username: map['username'],
      birthdate:map['birthdate']!=null ? DateTime.parse(map['birthdate']):DateTime.now(),
      gender: map['gender'],
      avatar: map['avatar'],
      postalCode: map['postalCode'],
      dniNumber: map['dniNumber'],
      passportNumber: map['passportNumber'],
      phoneNumber: map['phoneNumber'],
      roles: List<String>.from(map['roles']),
    );
  }

  static String? _hashPassword(String? password) {
    if (password != null && password.isNotEmpty) {
      return BCrypt.hashpw(password, BCrypt.gensalt());
    }
    return null;
  }

  bool verifyPassword(String userEnteredPassword) {
    return BCrypt.checkpw(
      userEnteredPassword,
      password!,
    );
  }

  String toJson() => json.encode(toMap());

  User copyWith({
    // String? id,
    String? email,
    String? password,
    String? name,
    String? lastname,
    String? username,
    DateTime? birthdate,
    String? gender,
    String? avatar,
    String? postalCode,
    String? dniNumber,
    String? passportNumber,
    String? phoneNumber,
    List<String>? roles,
    required int propertiesNumber,
  }) {
    return User(
      // id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      postalCode: postalCode ?? this.postalCode,
      dniNumber: dniNumber ?? this.dniNumber,
      passportNumber: passportNumber ?? this.passportNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      roles: roles ?? this.roles,
    );
  }

  @override
  List<Object?> get props => [
        // id,
        email,
        password,
        name,
        lastname,
        username,
        birthdate,
        gender,
        avatar,
        postalCode,
        dniNumber,
        passportNumber,
        phoneNumber,
        roles,
      ];
}

const emptyUser = User(
  email: '',
  birthdate: null,
  dniNumber: null,
  gender: '',
  avatar: '',
  lastname: '',
  name: '',
  passportNumber: null,
  phoneNumber: null,
  password: null,
  postalCode: null,
  roles: [],
  username: '',
);
