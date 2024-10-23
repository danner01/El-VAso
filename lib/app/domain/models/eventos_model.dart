// ignore: must_be_immutable
import 'dart:convert';
import 'dart:developer';

import 'package:bcrypt/bcrypt.dart';
import 'package:el_vaso/app/config/injection/injection.dart';
import 'package:el_vaso/app/config/local_storage/local_storage.dart';
import 'package:equatable/equatable.dart';

class Eventos extends Equatable {
  // final String? id;
  final String name;
  final String? disco;
  final String? imageUrl;
  final DateTime? dateEvent;
  final DateTime? dateInit;
  final DateTime? dateEnd;
  // final String? fecha;
  // final String? hora;

  const Eventos(
      {
      // this.id,
      required this.name,
      this.disco,
      this.imageUrl,
      this.dateEvent,
      this.dateInit,
      this.dateEnd
      // this.fecha,
      // this.hora
      });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'disco': disco,
      'imageUrl': imageUrl,
      'dateEvent': dateEvent,
      'dateInit': dateInit,
      'dateEnd': dateEnd
      // 'fecha': fecha,
      // 'hora': hora
    };
  }

  factory Eventos.fromJson(String str) => Eventos.fromMap(json.decode(str));
  factory Eventos.empty() => emptyDisco;

  factory Eventos.getDiscotecaLocal() {
    try {
      final localStorage = getIt.get<LocalStorage>();
      Map<String, dynamic> jsonData = json.decode(localStorage.disco);

      final localDiscoteca = Eventos.fromMap(jsonData);
      log('Local:$localDiscoteca');
      return localDiscoteca;
    } catch (e) {
      return Eventos.empty();
    }
  }

  factory Eventos.fromMap(Map<String, dynamic> map) {
    return Eventos(
        // id: map['id'],
        name: map['name'],
        disco: map['disco'],
        imageUrl: map['imageUrl'],
        dateEvent: map['dateEvent'],
        dateInit: map['dateInit'],
        dateEnd: map['dateEnd']
        // fecha: map['fecha'],
        // hora: map['hora'],
        );
  }

  String toJson() => json.encode(toMap());

  Eventos copyWith({
    // String? id,
    String? name,
    String? disco,
    String? imageUrl,
    DateTime? dateEvent,
    DateTime? dateInit,
    DateTime? dateEnd,
    // String? fecha,
    // String? hora,
  }) {
    return Eventos(
      // id: id ?? this.id,
      name: name ?? this.name,
      disco: disco ?? this.disco,
      imageUrl: imageUrl ?? this.imageUrl,
      dateEvent: dateEvent ?? this.dateEvent,
      dateInit: dateInit ?? this.dateInit,
      dateEnd: dateEnd ?? this.dateEnd,
      // fecha: fecha ?? this.fecha,
      // hora: hora ?? this.hora,
    );
  }

  static List<Eventos> fromJsonList(String source) {
    final List<dynamic> jsonData = json.decode(source);
    return jsonData.map((item) => Eventos.fromMap(item)).toList();
  }

  @override
  List<Object?> get props => [
        // id,
        name,
        disco,
        imageUrl,
        dateEvent,
        dateInit,
        dateEnd
        // fecha,
        // hora
      ];
}

const emptyDisco = Eventos(
  name: '',
);
