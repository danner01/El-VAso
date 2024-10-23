import 'dart:convert';

List<User> usersFromMap(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromMap(x)));

class User {
  const User({
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

  final String email;
  final String? password;
  final String? name;
  final String? lastname;
  final String? username;
  final DateTime? birthdate;
  final String? gender;
  final String? postalCode;
  final String? dniNumber;
  final String? passportNumber;
  final String? phoneNumber;
  final String? avatar;
  final List<String>? roles;

  factory User.initial() => const User(
        name: '',
        email: '',
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        lastname: json['lastname'],
        username: json['username'],
        birthdate: DateTime.parse(json['birthdate']),
        gender: json['gender'],
        avatar: json['avatar'],
        postalCode: json['postalCode'],
        dniNumber: json['dniNumber'],
        passportNumber: json['passportNumber'],
        phoneNumber: json['phoneNumber'],
        roles: List<String>.from(json['roles']),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "roles": List<dynamic>.from(roles!.map((x) => x)),
      };

  User copyWith({
    final String? email,
    final String? password,
    final String? name,
    final String? lastname,
    final String? username,
    final DateTime? birthdate,
    final String? gender,
    final String? avatar,
    final String? postalCode,
    final String? dniNumber,
    final String? passportNumber,
    final String? phoneNumber,
    final List<String>? roles,
  }) {
    return User(
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
}
