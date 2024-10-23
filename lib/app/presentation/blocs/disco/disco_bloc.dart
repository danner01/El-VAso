import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:el_vaso/app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:el_vaso/utilities/datafake/datafake.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import '../../../../utilities/enums/api_error_enum.dart';
import '../../../../utilities/enums/disco_state_enum.dart';
import '../../../config/injection/injection.dart';
import '../../../domain/models/api_error.dart';
import '../../../domain/models/discoteca_model.dart';
import '../../../domain/repositories/disco_repository.dart';
import '../internet_connectivity/internet_connectivity_bloc.dart';

part 'disco_event.dart';
part 'disco_state.dart';

class DiscoBloc extends Bloc<DiscoEvent, DiscoState> {
  final DiscoRepository _discoRepository;
  final InternetConnectivityBloc _internetConnection;

  final _logger = Logger();

  DiscoBloc({
    required DiscoRepository discoRepository,
    required InternetConnectivityBloc internetConnection,
  })  : _discoRepository = discoRepository,
        _internetConnection = internetConnection,
        super(const DiscoState()) {
    on<DiscoGetAllEvent>(_onDisco);
    on<DiscosFilterEvent>(_onFilter);
    on<SelectedDiscoEvent>(_selectedDisco);
    on<ResetDiscoEvent>(_resetStatesDisco);
  }

  void _onDisco(DiscoGetAllEvent event, Emitter<DiscoState> emit) async {
    // final isConnection = _checkInternetConnection();
    log('Cargar Discos');

    emit(
      state.copyWith(
          loading: true,
          getDiscoState: GetDiscoState.loading,
          apiError: const ApiError(apiErrorType: ApiErrorType.none)),
    );

    final resp = await _discoRepository.getAllDiscos();
    emit(state.copyWith(loading: false));

    resp.either(
      (left) {
        if (left.apiErrorType == ApiErrorType.unauthorized) {
          _logger.e(left.apiErrorType);
          getIt.get<AuthCubit>().logout();
        }
        // emit(state.copyWith(apiError: left));
        emit(state.copyWith(
            getDiscoState: GetDiscoState.success,
            apiError: left,
            discotecas: discotecasList,
            discosFiltradas: discotecasList,
            discosFavs: obtenerDiscotecasFavoritas(discotecasList)));
      },
      (right) => // emit(state.copyWith(apiError: left));
          emit(state.copyWith(
              getDiscoState: GetDiscoState.success,
              discotecas: right,
              discosFiltradas: right,
              discosFavs: obtenerDiscotecasFavoritas(right))),
    );
  }

  void _onFilter(DiscosFilterEvent event, Emitter<DiscoState> emit) async {
    // final isConnection = _checkInternetConnection();
    log('FIltros:${event.nombre},${event.ciudad},${event.provincia},${state.discotecas.length}');
    emit(state.copyWith(
        nameFilter: event.nombre,
        cityFilter: event.ciudad,
        provinceFilter: event.provincia,
        discosFiltradas: filtrarDiscotecas(
            discotecas: state.discotecas,
            nombre: event.nombre,
            ciudad: event.ciudad,
            provincia: event.provincia)));
  }

////////////////////////////////////////////////////////////////////////////////////////
  Discoteca? getDiscotecaByName(List<Discoteca> discotecas, String id) {
    try {
      // Filtra el array y devuelve la primera discoteca que coincide con el nombre
      return discotecas.firstWhere(
        (discoteca) => discoteca.id == id,
      );
    } catch (e) {
      return null; // En caso de que ocurra un error, se devuelve null
    }
  }

  void _selectedDisco(
      SelectedDiscoEvent event, Emitter<DiscoState> emit) async {
    emit(state.copyWith(getDiscoByIdState: GetDiscoByIdState.loading));

    final selectDisco = getDiscotecaByName(state.discotecas, event.discoId!);
    // final isConnection = _checkInternetConnection();
    emit(state.copyWith(
        selectDisco: selectDisco,
        getDiscoByIdState: GetDiscoByIdState.success));
  }

  void _resetStatesDisco(
      ResetDiscoEvent event, Emitter<DiscoState> emit) async {
    emit(state.copyWith(getDiscoByIdState: GetDiscoByIdState.cheking));
  }
  // bool _checkInternetConnection() {
  //   _internetConnection.add(CheckingInternetEvent());
  //   return _internetConnection.state == InternetConnectivityState.connected;
  // }
}

///////////////////////////////////////////////////////////////////////////
List<Discoteca> obtenerDiscotecasFavoritas(List<Discoteca> discotecas) {
  // Filtrar las discotecas favoritas
  List<Discoteca> favoritas =
      discotecas.where((discoteca) => discoteca.favorite!).toList();
  // Si no hay favoritas, retornar un arreglo vacío
  return favoritas.isEmpty ? [] : favoritas;
}

/////////////////////////////////////////////////////////////////
List<Discoteca> filtrarDiscotecas({
  required List<Discoteca> discotecas,
  String? nombre,
  String? ciudad,
  String? provincia,
}) {
  // Tratar cadenas vacías como si fueran null
  nombre = (nombre != null && nombre.trim().isNotEmpty) ? nombre : null;
  ciudad = (ciudad != null && ciudad.trim().isNotEmpty) ? ciudad : null;
  provincia =
      (provincia != null && provincia.trim().isNotEmpty) ? provincia : null;

  // Si todos los filtros son null o vacíos, devolver todas las discotecas
  if (nombre == null && ciudad == null && provincia == null) {
    return discotecas;
  }

  // Filtrar discotecas
  return discotecas.where((discoteca) {
    final coincideNombre = nombre == null ||
        (discoteca.name?.toLowerCase().contains(nombre.toLowerCase()) ?? false);
    final coincideCiudad = ciudad == null ||
        (discoteca.address?.toLowerCase().contains(ciudad.toLowerCase()) ??
            false);
    final coincideProvincia = provincia == null ||
        (discoteca.address?.toLowerCase().contains(provincia.toLowerCase()) ??
            false);

    // Retornar true solo si todos los filtros aplican
    return coincideNombre && coincideCiudad && coincideProvincia;
  }).toList();
}
