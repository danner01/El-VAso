import 'dart:convert';
import 'dart:io';

List<Vehicle> vehiclesFromMap(String str) =>
    List<Vehicle>.from(json.decode(str).map((x) => Vehicle.fromMap(x)));

class Vehicle {
  final String noLicence;
  final bool hasLtImport;
  final String noPlate;
  final String vehicleCondition;
  final String typeService;
  final String vehicleClass;
  final String brand;
  final String line;
  final String model;
  final String color;
  final String noMotor;
  final String noChasis;
  final String noVin;
  final String cylinderCapacity;
  final String bodyType;
  final String registrationDate;
  final String hasLeins;
  final String transitAgency;
  final String garments;
  final String classification;
  final String isReengravedEngine;
  final String isReengravedChassis;
  final String isReengravedSerie;
  final String isReengravedVin;
  final String classicAncient;
  final String fuelType;
  final String serviceCard;
  final String showRequests;
  final String securityState;
  final bool verValidaDian;
  final String repowered;
  final String doors;
  final String noEjes;
  final int mileage;
  final String soatExpiration;
  final String soatCompany;
  final String tecnoMechanicsExpiration;
  final String tecnoMechanicsCompany;
  final String tecnoMechanicsCertificate;
  final int ownerNumber;
  // ignore: library_private_types_in_public_api
  final List<_Photo> photos;
  final String owner;
  final dynamic administrator;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  //------------------------------------
  final String? status;
  final String? department;
  final String? city;
  final int? price;
  final bool negotiable;
  final double? lat;
  final double? long;
  final String? description;
  final List<File> imageFiles;

  Vehicle({
    required this.noLicence,
    required this.hasLtImport,
    required this.noPlate,
    required this.vehicleCondition,
    required this.typeService,
    required this.vehicleClass,
    required this.brand,
    required this.line,
    required this.model,
    required this.color,
    required this.noMotor,
    required this.noChasis,
    required this.noVin,
    required this.cylinderCapacity,
    required this.bodyType,
    required this.registrationDate,
    required this.hasLeins,
    required this.transitAgency,
    required this.garments,
    required this.classification,
    required this.isReengravedEngine,
    required this.isReengravedChassis,
    required this.isReengravedSerie,
    required this.isReengravedVin,
    required this.classicAncient,
    required this.fuelType,
    required this.serviceCard,
    required this.showRequests,
    required this.securityState,
    required this.verValidaDian,
    required this.repowered,
    required this.doors,
    required this.noEjes,
    required this.mileage,
    required this.soatExpiration,
    required this.soatCompany,
    required this.tecnoMechanicsExpiration,
    required this.tecnoMechanicsCompany,
    required this.tecnoMechanicsCertificate,
    required this.ownerNumber,
    required this.photos,
    required this.owner,
    required this.administrator,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    //------------------------------------
    this.status,
    this.department,
    this.city,
    this.price,
    this.negotiable = false,
    this.lat,
    this.long,
    this.description,
    this.imageFiles = const [],
  });

  String get name => '$brand $line $model $cylinderCapacity CC';

  Vehicle copyWith({
    String? noLicence,
    bool? hasLtImport,
    String? noPlate,
    String? vehicleCondition,
    String? typeService,
    String? vehicleClass,
    String? brand,
    String? line,
    String? model,
    String? color,
    String? noMotor,
    String? noChasis,
    String? noVin,
    String? cylinderCapacity,
    String? bodyType,
    String? registrationDate,
    String? hasLeins,
    String? transitAgency,
    String? garments,
    String? classification,
    String? isReengravedEngine,
    String? isReengravedChassis,
    String? isReengravedSerie,
    String? isReengravedVin,
    String? classicAncient,
    String? fuelType,
    String? serviceCard,
    String? showRequests,
    String? securityState,
    bool? verValidaDian,
    String? repowered,
    String? doors,
    String? noEjes,
    int? mileage,
    String? soatExpiration,
    String? soatCompany,
    String? tecnoMechanicsExpiration,
    String? tecnoMechanicsCompany,
    String? tecnoMechanicsCertificate,
    int? ownerNumber,
    // ignore: library_private_types_in_public_api
    List<_Photo>? photos,
    String? owner,
    dynamic administrator,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    //------------------------------------
    String? status,
    String? department,
    String? city,
    int? price,
    bool? negotiable,
    double? lat,
    double? long,
    String? description,
    List<File>? imageFiles,
  }) =>
      Vehicle(
        noLicence: noLicence ?? this.noLicence,
        hasLtImport: hasLtImport ?? this.hasLtImport,
        noPlate: noPlate ?? this.noPlate,
        vehicleCondition: vehicleCondition ?? this.vehicleCondition,
        typeService: typeService ?? this.typeService,
        vehicleClass: vehicleClass ?? this.vehicleClass,
        brand: brand ?? this.brand,
        line: line ?? this.line,
        model: model ?? this.model,
        color: color ?? this.color,
        noMotor: noMotor ?? this.noMotor,
        noChasis: noChasis ?? this.noChasis,
        noVin: noVin ?? this.noVin,
        cylinderCapacity: cylinderCapacity ?? this.cylinderCapacity,
        bodyType: bodyType ?? this.bodyType,
        registrationDate: registrationDate ?? this.registrationDate,
        hasLeins: hasLeins ?? this.hasLeins,
        transitAgency: transitAgency ?? this.transitAgency,
        garments: garments ?? this.garments,
        classification: classification ?? this.classification,
        isReengravedEngine: isReengravedEngine ?? this.isReengravedEngine,
        isReengravedChassis: isReengravedChassis ?? this.isReengravedChassis,
        isReengravedSerie: isReengravedSerie ?? this.isReengravedSerie,
        isReengravedVin: isReengravedVin ?? this.isReengravedVin,
        classicAncient: classicAncient ?? this.classicAncient,
        fuelType: fuelType ?? this.fuelType,
        serviceCard: serviceCard ?? this.serviceCard,
        showRequests: showRequests ?? this.showRequests,
        securityState: securityState ?? this.securityState,
        verValidaDian: verValidaDian ?? this.verValidaDian,
        repowered: repowered ?? this.repowered,
        doors: doors ?? this.doors,
        noEjes: noEjes ?? this.noEjes,
        mileage: mileage ?? this.mileage,
        soatExpiration: soatExpiration ?? this.soatExpiration,
        soatCompany: soatCompany ?? this.soatCompany,
        tecnoMechanicsExpiration:
            tecnoMechanicsExpiration ?? this.tecnoMechanicsExpiration,
        tecnoMechanicsCompany:
            tecnoMechanicsCompany ?? this.tecnoMechanicsCompany,
        tecnoMechanicsCertificate:
            tecnoMechanicsCertificate ?? this.tecnoMechanicsCertificate,
        ownerNumber: ownerNumber ?? this.ownerNumber,
        photos: photos ?? this.photos,
        owner: owner ?? this.owner,
        administrator: administrator ?? this.administrator,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        //------------------------------------
        status: status ?? this.status,
        department: department ?? this.department,
        city: city ?? this.city,
        price: price ?? this.price,
        negotiable: negotiable ?? this.negotiable,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        description: description ?? this.description,
        imageFiles: imageFiles ?? this.imageFiles,
      );

  factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        noLicence: json["noLicence"] ?? '',
        hasLtImport: json["has_LTImport"] ?? '',
        noPlate: json["noPlate"] ?? '',
        vehicleCondition: json["vehicle_condition"] ?? '',
        typeService: json["type_service"] ?? '',
        vehicleClass: json["vehicle_class"] ?? '',
        brand: json["brand"] ?? '',
        line: json["line"] ?? '',
        model: json["model"] ?? '',
        color: json["color"] ?? '',
        noMotor: json["noMotor"] ?? '',
        noChasis: json["noChasis"] ?? '',
        noVin: json["noVin"] ?? '',
        cylinderCapacity: json["cylinder_capacity"] ?? '',
        bodyType: json["body_type"] ?? '',
        registrationDate: json["registration_date"] ?? '',
        hasLeins: json["has_leins"] ?? '',
        transitAgency: json["transit_agency"] ?? '',
        garments: json["garments"] ?? '',
        classification: json["classification"] ?? '',
        isReengravedEngine: json["is_reengraved_engine"] ?? '',
        isReengravedChassis: json["is_reengraved_chassis"] ?? '',
        isReengravedSerie: json["is_reengraved_serie"] ?? '',
        isReengravedVin: json["is_reengraved_vin"] ?? '',
        classicAncient: json["classic_ancient"] ?? '',
        fuelType: json["fuel_type"] ?? '',
        serviceCard: json["service_card"] ?? '',
        showRequests: json["show_requests"] ?? '',
        securityState: json["security_state"] ?? '',
        verValidaDian: json["verValidaDIAN"] ?? '',
        repowered: json["repowered"] ?? '',
        doors: json["doors"] ?? '',
        noEjes: json["no_ejes"] ?? '',
        mileage: json["mileage"] ?? 0,
        soatExpiration: json["soat_expiration"] ?? '',
        soatCompany: json["soat_company"] ?? '',
        tecnoMechanicsExpiration: json["tecno_mechanics_expiration"] ?? '',
        tecnoMechanicsCompany: json["tecno_mechanics_company"] ?? '',
        tecnoMechanicsCertificate: json["tecno_mechanics_certificate"] ?? '',
        ownerNumber: json["owner_number"] ?? '',
        photos: json["photos"] == null
            ? []
            : List<_Photo>.from(json["photos"].map((x) => _Photo.fromMap(x))),
        owner: json["owner"] ?? '',
        administrator: json["administrator"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        //------------------------------------
        status: json["status"],
        department: json["department"],
        city: json["city"],
        price: json["price"],
        negotiable: json["negotiable"] ?? false,
        lat: json["lat"],
        long: json["long"],
        description: json["description"],
      );

  Map<String, String> toMap() => {
        "id": id,
        "mileage": mileage.toString(),
        //------------------------------------
        if (status != null) "status": status.toString(),
        if (department != null) "department": department.toString(),
        if (city != null) "city": city.toString(),
        if (price != null) "price": price.toString(),
        "negotiable": negotiable.toString(),
        if (lat != null) "lat": lat.toString(),
        if (long != null) "long": long.toString(),
        if (description != null) "description": description.toString(),
      };
}

class _Photo {
  final String id;
  final String url;
  final String key;

  _Photo({
    required this.id,
    required this.url,
    required this.key,
  });

  _Photo copyWith({
    String? id,
    String? url,
    String? key,
  }) =>
      _Photo(
        id: id ?? this.id,
        url: url ?? this.url,
        key: key ?? this.key,
      );

  // factory _Photo.fromJson(String str) => _Photo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _Photo.fromMap(Map<String, dynamic> json) => _Photo(
        id: json["_id"],
        url: json["url"],
        key: json["key"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "url": url,
        "key": key,
      };
}
