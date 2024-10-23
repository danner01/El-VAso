import 'dart:convert';

List<Unity> unitsFromMap(String str) =>
    List<Unity>.from(json.decode(str).map((x) => Unity.fromMap(x)));

String unitsMap(List<Unity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Unity {
  final String id;
  final String uName;
  final String uType;
  final DateTime buidDate;
  final String description;
  final String idType;
  final String identification;
  final String phone;
  final String email;
  final String depart;
  final String city;
  final String neighborhood;
  final String propertysTypes;
  final int nBlocks;
  final int? nFloors;
  final int nPropertys;
  final String nomenclature;
  // final String ftoken;
  final String? banner;

  Unity({
    required this.id,
    required this.uName,
    required this.uType,
    required this.buidDate,
    required this.description,
    required this.idType,
    required this.identification,
    required this.phone,
    required this.email,
    required this.depart,
    required this.city,
    required this.neighborhood,
    required this.propertysTypes,
    required this.nBlocks,
    required this.nFloors,
    required this.nPropertys,
    required this.nomenclature,
    // required this.ftoken,
    this.banner,
  });

  factory Unity.empty() => Unity(
        id: '',
        uName: '',
        uType: '',
        buidDate: DateTime.now(),
        description: '',
        idType: '',
        identification: '',
        phone: '',
        email: '',
        depart: '',
        city: '',
        neighborhood: '',
        propertysTypes: '',
        nBlocks: 0,
        nFloors: 0,
        nPropertys: 0,
        nomenclature: '',
        // ftoken: '',
      );

  Unity copyWith({
    String? id,
    String? uName,
    String? uType,
    DateTime? buidDate,
    String? description,
    String? idType,
    String? identification,
    String? phone,
    String? email,
    String? depart,
    String? city,
    String? neighborhood,
    String? propertysTypes,
    int? nBlocks,
    int? nFloors,
    int? nPropertys,
    String? nomenclature,
    // String? ftoken,
    String? banner,
  }) =>
      Unity(
        id: id ?? this.id,
        uName: uName ?? this.uName,
        uType: uType ?? this.uType,
        buidDate: buidDate ?? this.buidDate,
        description: description ?? this.description,
        idType: idType ?? this.idType,
        identification: identification ?? this.identification,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        depart: depart ?? this.depart,
        city: city ?? this.city,
        neighborhood: neighborhood ?? this.neighborhood,
        propertysTypes: propertysTypes ?? this.propertysTypes,
        nBlocks: nBlocks ?? this.nBlocks,
        nFloors: nFloors ?? this.nFloors,
        nPropertys: nPropertys ?? this.nPropertys,
        nomenclature: nomenclature ?? this.nomenclature,
        // ftoken: ftoken ?? this.ftoken,
        // banner: banner ?? this.banner,
      );

  factory Unity.fromJson(String str) => Unity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Unity.fromMap(Map<String, dynamic> json) {
    String? bannerUrl;
    var bannerObj = json['banner'];

    if (bannerObj is Map) {
      bannerUrl = bannerObj['url'] as String?;
    } else if (bannerObj == null) {
      bannerUrl = null;
    } else {
      bannerUrl = null;
    }

    return Unity(
      id: json["_id"],
      uName: json["u_name"] ?? '',
      uType: json["u_type"],
      buidDate: DateTime.parse(json["buid_date"]),
      description: json["description"] ?? '',
      idType: json["id_type"] ?? '',
      identification: json["identification"] ?? '',
      phone: json["phone"] ?? '',
      email: json["email"] ?? '',
      depart: json["depart"] ?? '',
      city: json["city"] ?? '',
      neighborhood: json["neighborhood"] ?? '',
      propertysTypes: json["propertys_types"] ?? '',
      nBlocks: json["n_blocks"] ?? 0,
      nFloors: json["n_floors"] ?? 0,
      nPropertys: json["n_propertys"] ?? 0,
      nomenclature: json["nomenclature"] ?? '',
      // ftoken: json["administrator"] is Map
      //     ? json["administrator"]["ftoken"]
      //     : json["administrator"] ?? '',
      banner: bannerUrl,
    );
  }

  Map<String, dynamic> toMap() => {
        "_id": id,
        "u_name": uName,
        "u_type": uType,
        "buid_date": buidDate.toIso8601String(),
        "description": description,
        "id_type": idType,
        "identification": identification,
        "phone": phone,
        "email": email,
        "depart": depart,
        "city": city,
        "neighborhood": neighborhood,
        "propertys_types": propertysTypes,
        "n_blocks": nBlocks,
        "n_floors": nFloors,
        "n_propertys": nPropertys,
        "nomenclature": nomenclature,
      };
}
