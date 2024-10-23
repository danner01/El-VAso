import 'dart:convert';

class Configs {
  final bool onboardingIsFinished;
  final bool isOwnerRol;

  Configs({
    required this.onboardingIsFinished,
    required this.isOwnerRol,
  });

  factory Configs.defaultValue() {
    return Configs(
      onboardingIsFinished: false,
      isOwnerRol: false,
    );
  }

  factory Configs.fromJson(String str) => Configs.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Configs.fromMap(Map<String, dynamic> map) {
    return Configs(
      onboardingIsFinished: map['onboardingIsFinished'] ?? false,
      isOwnerRol: map['isOwnerRol'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'onboardingIsFinished': onboardingIsFinished,
      'isOwnerRol': isOwnerRol,
    };
  }

  Configs copyWith({
    bool? onboardingIsFinished,
    bool? isOwnerRol,
  }) {
    return Configs(
      onboardingIsFinished: onboardingIsFinished ?? this.onboardingIsFinished,
      isOwnerRol: isOwnerRol ?? this.isOwnerRol,
    );
  }
}
