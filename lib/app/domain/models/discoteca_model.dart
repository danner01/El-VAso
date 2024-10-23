import 'dart:convert';
import 'package:equatable/equatable.dart';

class Discoteca extends Equatable {
  final String? id;
  final String? name;
  final String? address;
  final String? maps;
  final String? logo;
  final String? banner;
  final String? description;
  final String? instagram;
  final String? facebook;
  final String? twitter;
  final String? tiktok;
  final String? time;
  final int? capacity;
  final List<String>? musicGenre;
  final bool? vip;
  final bool? smookingArea;
  final bool? parking;
  final bool? promoted;
  final double? longitude;
  final double? latitude;
  final bool? favorite;
  final String? city; // Nueva variable
  final String? province; // Nueva variable

  const Discoteca({
    required this.id,
    required this.name,
    required this.address,
    required this.maps,
    required this.logo,
    required this.banner,
    required this.description,
    required this.instagram,
    required this.facebook,
    required this.twitter,
    required this.tiktok,
    required this.time,
    required this.capacity,
    required this.musicGenre,
    required this.vip,
    required this.smookingArea,
    required this.parking,
    required this.promoted,
    required this.longitude,
    required this.latitude,
    required this.favorite,
    required this.city, // Inicialización
    required this.province, // Inicialización
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'maps': maps,
      'logo': logo,
      'banner': banner,
      'description': description,
      'instagram': instagram,
      'facebook': facebook,
      'twitter': twitter,
      'tiktok': tiktok,
      'time': time,
      'capacity': capacity,
      'music_genre': musicGenre,
      'vip': vip,
      'smooking_area': smookingArea,
      'parking': parking,
      'promoted': promoted,
      'longitude': longitude,
      'latitude': latitude,
      'favorite': favorite,
      'city': city, // Mapeo de city
      'province': province, // Mapeo de province
    };
  }

  factory Discoteca.fromMap(Map<String, dynamic> map) {
    return Discoteca(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      maps: map['maps'],
      logo: map['logo'],
      banner: map['banner'],
      description: map['description'],
      instagram: map['instagram'],
      facebook: map['facebook'],
      twitter: map['twitter'],
      tiktok: map['tiktok'],
      time: map['time'],
      capacity: map['capacity'],
      musicGenre: List<String>.from(map['music_genre']),
      vip: map['vip'],
      smookingArea: map['smooking_area'],
      parking: map['parking'],
      promoted: map['promoted'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      favorite: map['favorite'],
      city: map['city'], // Asignación de city
      province: map['province'], // Asignación de province
    );
  }

  String toJson() => json.encode(toMap());

  factory Discoteca.fromJson(String source) =>
      Discoteca.fromMap(json.decode(source));

  Discoteca copyWith({
    String? id,
    String? name,
    String? address,
    String? maps,
    String? logo,
    String? banner,
    String? description,
    String? instagram,
    String? facebook,
    String? twitter,
    String? tiktok,
    String? time,
    int? capacity,
    List<String>? musicGenre,
    bool? vip,
    bool? smookingArea,
    bool? parking,
    bool? promoted,
    double? longitude,
    double? latitude,
    bool? favorite,
    String? city,
    String? province,
  }) {
    return Discoteca(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      maps: maps ?? this.maps,
      logo: logo ?? this.logo,
      banner: banner ?? this.banner,
      description: description ?? this.description,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      tiktok: tiktok ?? this.tiktok,
      time: time ?? this.time,
      capacity: capacity ?? this.capacity,
      musicGenre: musicGenre ?? this.musicGenre,
      vip: vip ?? this.vip,
      smookingArea: smookingArea ?? this.smookingArea,
      parking: parking ?? this.parking,
      promoted: promoted ?? this.promoted,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      favorite: favorite ?? this.favorite,
      city: city ?? this.city, // copyWith de city
      province: province ?? this.province, // copyWith de province
    );
  }

  /// Método para decodificar una lista de Discoteca desde un JSON.
  static List<Discoteca> fromJsonList(String source) {
    final List<dynamic> jsonData = json.decode(source);
    return jsonData.map((item) => Discoteca.fromMap(item)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        maps,
        logo,
        banner,
        description,
        instagram,
        facebook,
        twitter,
        tiktok,
        time,
        capacity,
        musicGenre,
        vip,
        smookingArea,
        parking,
        promoted,
        longitude,
        latitude,
        favorite,
        city, // Agregar city a props
        province, // Agregar province a props
      ];
}

const discoEmpty = Discoteca(
    id: '',
    name: '',
    address: '',
    maps: '',
    logo: '',
    banner: '',
    description: '',
    instagram: '',
    facebook: '',
    twitter: '',
    tiktok: '',
    time: '',
    capacity: 0,
    musicGenre: [],
    vip: false,
    smookingArea: false,
    parking: false,
    promoted: false,
    longitude: 0,
    latitude: 0,
    favorite: false,
    city: '',
    province: '');
