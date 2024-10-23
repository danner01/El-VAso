import 'dart:convert';

List<Department> departmentsFromMap(String str) =>
    List<Department>.from(json.decode(str).map((x) => Department.fromMap(x)));

String departmentsToMap(List<Department> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Department {
  final int idDep;
  final String name;
  final List<City> cities;

  Department({
    required this.idDep,
    required this.name,
    required this.cities,
  });

  Department copyWith({
    int? idDep,
    String? name,
    List<City>? cities,
  }) =>
      Department(
        idDep: idDep ?? this.idDep,
        name: name ?? this.name,
        cities: cities ?? this.cities,
      );

  factory Department.fromMap(Map<String, dynamic> json) => Department(
        idDep: json["id_dep"],
        name: json["palabra"],
        cities: List<City>.from(json["ciudades"].map((x) => City.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_dep": idDep,
        "palabra": name,
        // "ciudades": List<City>.from(cities.map((x) => x.toMap())),
      };

  @override
  String toString() => name;

  bool isEqual(Department model) {
    return idDep == model.idDep;
  }
}

class City {
  final String name;
  final String code;

  City({
    required this.name,
    required this.code,
  });

  City copyWith({
    String? name,
    String? code,
  }) =>
      City(
        name: name ?? this.name,
        code: code ?? this.code,
      );

  factory City.fromMap(Map<String, dynamic> json) => City(
        name: json["ciudad"],
        code: json["codigo"],
      );

  Map<String, dynamic> toMap() => {
        "ciudad": name,
        "codigo": code,
      };

  @override
  String toString() => name;

  bool isEqual(City model) {
    return code == model.code;
  }
}
