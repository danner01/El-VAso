import 'dart:convert';

List<Noti> notiFromMap(String str) =>
    List<Noti>.from(json.decode(str).map((x) => Noti.fromMap(x)));

String notiToMap(List<Noti> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Noti {
  final String id;
  final String title;
  final String body;
  // final PropertyInNoti property;
  final UserInNoti user;
  final DateTime date;
  final String unityName;
  final String category;
  final DateTime? endTime;

  Noti({
    required this.id,
    required this.title,
    required this.body,
    // required this.property,
    required this.user,
    required this.date,
    this.unityName = '',
    this.category = '',
    this.endTime,
  });

  Noti copyWith({
    String? id,
    String? title,
    String? body,
    // PropertyInNoti? property,
    UserInNoti? user,
    DateTime? date,
    String? category,
    DateTime? endTime,
  }) =>
      Noti(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        // property: property ?? this.property,
        user: user ?? this.user,
        date: date ?? this.date,
        category: category ?? this.category,
        endTime: endTime ?? this.endTime,
      );

  factory Noti.fromMap(Map<String, dynamic> json) => Noti(
        id: json["_id"],
        title: json["title"],
        body: json["body"],
        // property: PropertyInNoti.fromMap(json["property"]),
        user: UserInNoti.fromMap(json["user"]),
        date: DateTime.parse(json["createdAt"]),
        unityName: json["unity"] != null ? json["unity"]["u_name"] : '',
        category: json["category"],
        endTime:
            json["endTime"] != null ? DateTime.parse(json["endTime"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "body": body,
        // "property": property.toMap(),
        "user": user.toMap(),
      };
}

class PropertyInNoti {
  final String id;
  final String nomenclature;
  final UnityInNoti unity;

  PropertyInNoti({
    required this.id,
    required this.nomenclature,
    required this.unity,
  });

  PropertyInNoti copyWith({
    String? id,
    String? nomenclature,
    UnityInNoti? unity,
  }) =>
      PropertyInNoti(
        id: id ?? this.id,
        nomenclature: nomenclature ?? this.nomenclature,
        unity: unity ?? this.unity,
      );

  factory PropertyInNoti.fromMap(Map<String, dynamic> json) => PropertyInNoti(
        id: json["_id"],
        nomenclature: json["nomenclature"],
        unity: UnityInNoti.fromMap(json["unity"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nomenclature": nomenclature,
        "unity": unity.toMap(),
      };
}

class UnityInNoti {
  final String id;
  final String uName;

  UnityInNoti({
    required this.id,
    required this.uName,
  });

  UnityInNoti copyWith({
    String? id,
    String? uName,
  }) =>
      UnityInNoti(
        id: id ?? this.id,
        uName: uName ?? this.uName,
      );

  factory UnityInNoti.fromMap(Map<String, dynamic> json) => UnityInNoti(
        id: json["_id"],
        uName: json["u_name"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "u_name": uName,
      };
}

class UserInNoti {
  final String id;
  final String name;
  final String email;

  UserInNoti({
    required this.id,
    required this.name,
    required this.email,
  });

  UserInNoti copyWith({
    String? id,
    String? name,
    String? email,
  }) =>
      UserInNoti(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory UserInNoti.fromMap(Map<String, dynamic> json) => UserInNoti(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "email": email,
      };
}
