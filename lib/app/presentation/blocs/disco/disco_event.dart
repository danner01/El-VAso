part of 'disco_bloc.dart';

abstract class DiscoEvent extends Equatable {
  const DiscoEvent();
  @override
  List<Object> get props => [];
}

class DiscoGetAllEvent extends DiscoEvent {
  const DiscoGetAllEvent();
}

class DiscoGetFavsEvent extends DiscoEvent {
  final List<Discoteca>? discotecas;
  const DiscoGetFavsEvent(this.discotecas);
}

class DiscosFilterEvent extends DiscoEvent {
  final String? nombre;
  final String? ciudad;
  final String? provincia;
  const DiscosFilterEvent(
    this.nombre,
    this.ciudad,
    this.provincia,
  );
}

class SelectedDiscoEvent extends DiscoEvent {
  final String? discoId;
  const SelectedDiscoEvent(this.discoId);
}

class ResetDiscoEvent extends DiscoEvent {}
