import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../utilities/enums/property_types_enum.dart';
import 'unity_entity.dart';

List<Property> propertiesResponseFromMap(String str) =>
    List<Property>.from(json.decode(str).map((x) => Property.fromMap(x)));

class Property extends Equatable {
  final String id;
  final PropertyTypes propertyType;
  final int area;
  final int pisos;
  final int habitaciones;
  final int banos;
  final int parqueaderoPrivado;
  //----------------------------
  final int cuartosServicios;
  final int closets;
  final int terrazas;
  final int patios;
  final int balcones;

  //----------------------------
  final bool cuartoUtil;
  final bool zonaSecado;
  final bool redGas;
  final bool calentador;
  final bool cuartosLinos;

  final List<File> imageFiles;

  final String? type;
  final int? block;
  final int? floor;
  final int? number;
  final String? nomenclature;
  final Unity? unity;
  // ignore: library_private_types_in_public_api
  final List<_Photo> photos;
  final String? tipoInmueble;
  final bool active;
  final String description;
  final int precioVenta;

  const Property({
    this.id = '', //64c1146d7f59617f5eb1a4ff
    this.propertyType = PropertyTypes.none,
    this.area = 0,
    this.pisos = 0,
    this.habitaciones = 0,
    this.banos = 0,
    this.parqueaderoPrivado = 0,
    //----------------------------
    this.cuartosServicios = 0,
    this.closets = 0,
    this.terrazas = 0,
    this.patios = 0,
    this.balcones = 0,
    //----------------------------
    this.cuartoUtil = false,
    this.zonaSecado = false,
    this.redGas = false,
    this.calentador = false,
    this.cuartosLinos = false,
    this.imageFiles = const [],
    this.type,
    this.block,
    this.floor,
    this.number,
    this.nomenclature,
    this.unity,
    this.photos = const [],
    this.tipoInmueble,
    this.active = false,
    this.description = '',
    this.precioVenta = 0,
  });

  factory Property.fromJson(String str) => Property.fromMap(json.decode(str));

  factory Property.fromMap(Map<String, dynamic> json) => Property(
        id: json["_id"],
        tipoInmueble: json["type_property"] ?? '',
        type: json["type"] ?? '',
        block: json["block"] ?? 0,
        floor: json["floor"] ?? 0,
        number: json["number"] ?? 0,
        nomenclature: json["nomenclature"] ?? '',

        photos: json["photos"] == null
            ? []
            : List<_Photo>.from(json["photos"].map((x) => _Photo.fromMap(x))),

        // residents: List<dynamic>.from(json["residents"].map((x) => x)),
        // unity: Unity.empty(),
        unity: json['unity'] == null
            ? null
            : json['unity'] is Map
                ? Unity.fromMap(json["unity"])
                : Unity.empty().copyWith(id: json['unity']),
        balcones: json["balconies"] ?? 0,
        closets: json["closets"] ?? 0,
        // dryingArea: json["drying_area"],
        redGas: json["gas_network"] ?? false,
        calentador: json["heater"] ?? false,
        cuartosLinos: json["linen_room"] ?? false,
        zonaSecado: json["drying_area"] ?? false,
        cuartoUtil: json["utility_room"] ?? false,

        cuartosServicios: json["service_room"] ?? 0,
        terrazas: json["terraces"] ?? 0,

        patios: json["yards"] ?? 0,
        active: json["active"] ?? true,
        habitaciones: json["rooms"] ?? 0,
        // area: json["area"] ?? 0,
        banos: json["baths"] ?? 0,
        parqueaderoPrivado: json["private_parking"] == null
            ? 0
            : json["private_parking"] is bool
                ? 0
                : json["private_parking"],
        description: json["description"] ?? '',
        precioVenta: json["sale_price"] ?? 0,
      );

  Property copyWith({
    String? id,
    PropertyTypes? propertyType,
    int? area,
    int? pisos,
    int? habitaciones,
    int? banos,
    int? parqueaderoPrivado,
    int? cuartosServicios,
    int? closets,
    int? terrazas,
    int? patios,
    int? balcones,
    bool? cuartoUtil,
    bool? zonaSecado,
    bool? redGas,
    bool? calentador,
    bool? cuartosLinos,
    List<File>? imageFiles,
    String? type,
    int? block,
    int? floor,
    int? number,
    String? tipoInmueble,
    String? nomenclature,
    // ignore: library_private_types_in_public_api
    List<_Photo>? photos,
    bool? active,
    String? description,
    int? precioVenta,
  }) {
    return Property(
      id: id ?? this.id,
      propertyType: propertyType ?? this.propertyType,
      area: area ?? this.area,
      pisos: pisos ?? this.pisos,
      habitaciones: habitaciones ?? this.habitaciones,
      banos: banos ?? this.banos,
      parqueaderoPrivado: parqueaderoPrivado ?? this.parqueaderoPrivado,
      cuartosServicios: cuartosServicios ?? this.cuartosServicios,
      closets: closets ?? this.closets,
      terrazas: terrazas ?? this.terrazas,
      patios: patios ?? this.patios,
      balcones: balcones ?? this.balcones,
      cuartoUtil: cuartoUtil ?? this.cuartoUtil,
      zonaSecado: zonaSecado ?? this.zonaSecado,
      redGas: redGas ?? this.redGas,
      calentador: calentador ?? this.calentador,
      cuartosLinos: cuartosLinos ?? this.cuartosLinos,
      imageFiles: imageFiles ?? this.imageFiles,
      type: type ?? this.type,
      block: block ?? this.block,
      floor: floor ?? this.floor,
      number: number ?? this.number,
      tipoInmueble: tipoInmueble ?? this.tipoInmueble,
      nomenclature: nomenclature ?? this.nomenclature,
      photos: photos ?? this.photos,
      active: active ?? this.active,
      description: description ?? this.description,
      precioVenta: precioVenta ?? this.precioVenta,
    );
  }

  @override
  String toString() {
    return 'Property{'
        'tipoInmueble: $tipoInmueble, '
        'number: $number, '
        'nomenclature: $nomenclature, '
        'block: $block, '
        'propertyType: $propertyType, '
        'area: $area, '
        'pisos: $pisos, '
        'habitaciones: $habitaciones, '
        'banos: $banos, '
        'parqueaderoPrivado: $parqueaderoPrivado, '
        'cuartosServicios: $cuartosServicios, '
        'closets: $closets, '
        'terrazas: $terrazas, '
        'patios: $patios, '
        'balcones: $balcones, '
        'cuartoUtil: $cuartoUtil, '
        'zonaSecado: $zonaSecado, '
        'redGas: $redGas, '
        'calentador: $calentador, '
        'cuartosLinos: $cuartosLinos'
        'area: $area'
        'banos: $banos'
        'parqueaderoPrivado: $parqueaderoPrivado'
        'description: $description'
        'precioVenta: $precioVenta'
        'habitaciones: $habitaciones'
        '}';
  }

  Map<String, String> toMap() {
    return {
      'id': id,
      'service_room': cuartosServicios.toString(),
      'closets': closets.toString(),
      'terraces': terrazas.toString(),
      'yards': patios.toString(),
      'balconies': balcones.toString(),
      'utility_room': cuartoUtil.toString(),
      'drying_area': zonaSecado.toString(),
      'gas_network': redGas.toString(),
      'heater': calentador.toString(),
      'linen_room': cuartosLinos.toString(),
      'area': area.toString(),
      'rooms': habitaciones.toString(),
      'baths': banos.toString(),
      'private_parking': parqueaderoPrivado.toString(),
      'description': description,
      'sale_price': precioVenta.toString(),
      'type_property': tipoInmueble.toString()
    };
  }

  String getNomenclature() {
    // {Tipo de apartamento} {numero del inmueble} {tipo de (bloque ó torre) } {# bloque ó torre}
    return '$type $number, bloque $block - piso $floor';
  }

  String getAddres() {
    return '$type $number B$block:$number';
  }

  String getUbication() => '${unity!.city}, ${unity!.depart}';

  @override
  List<Object?> get props => [
        id,
        propertyType,
        area,
        pisos,
        habitaciones,
        banos,
        parqueaderoPrivado,
        cuartosServicios,
        closets,
        terrazas,
        patios,
        balcones,
        cuartoUtil,
        zonaSecado,
        redGas,
        calentador,
        cuartosLinos,
        imageFiles,
        type,
        block,
        floor,
        number,
        photos,
        precioVenta,
        description,
        active,
        tipoInmueble,
      ];
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
