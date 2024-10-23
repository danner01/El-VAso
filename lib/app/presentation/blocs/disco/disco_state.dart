part of 'disco_bloc.dart';

const initialDisco = <Discoteca>[];

class DiscoState extends Equatable {
  final List<Discoteca> discotecas;
  final List<Discoteca> discosFavs;
  final Discoteca selectDisco;

  final GetDiscoState getDiscoState;
  final GetFavDiscoState getFavDiscoState;
  final GetDiscoByIdState getDiscoByIdState;

  final List<Discoteca> discosFiltradas;
  final String provinceFilter;
  final String cityFilter;
  final String nameFilter;
  final bool isUdapte;
  final bool loading;
  final ApiError apiError;
  final bool isUpdate;

  const DiscoState({
    this.discotecas = initialDisco,
    this.discosFavs = initialDisco,
    this.discosFiltradas = initialDisco,
    this.getDiscoState = GetDiscoState.cheking,
    this.getFavDiscoState = GetFavDiscoState.cheking,
    this.getDiscoByIdState = GetDiscoByIdState.cheking,
    this.selectDisco = discoEmpty,
    this.nameFilter = '',
    this.provinceFilter = '',
    this.cityFilter = '',
    this.isUdapte = false,
    this.loading = false,
    this.apiError = const ApiError(apiErrorType: ApiErrorType.none),
    this.isUpdate = false,
  });

  DiscoState copyWith({
    List<Discoteca>? discotecas,
    List<Discoteca>? discosFavs,
    List<Discoteca>? discosFiltradas,
    GetDiscoState? getDiscoState,
    GetFavDiscoState? getFavDiscoState,
    GetDiscoByIdState? getDiscoByIdState,
    Discoteca? selectDisco,
    String? nameFilter,
    DateTime? dateFilter,
    String? provinceFilter,
    String? cityFilter,
    bool? isUdapte,
    bool? loading,
    ApiError? apiError,
    bool? isUpdate,
  }) {
    return DiscoState(
      discotecas: discotecas ?? this.discotecas,
      discosFavs: discosFavs ?? this.discosFavs,
      discosFiltradas: discosFiltradas ?? this.discosFiltradas,
      getDiscoState: getDiscoState ?? this.getDiscoState,
      getFavDiscoState: getFavDiscoState ?? this.getFavDiscoState,
      getDiscoByIdState: getDiscoByIdState ?? this.getDiscoByIdState,
      selectDisco: selectDisco ?? this.selectDisco,
      nameFilter: nameFilter ?? this.nameFilter,
      provinceFilter: provinceFilter ?? this.provinceFilter,
      cityFilter: cityFilter ?? this.cityFilter,
      isUdapte: isUdapte ?? this.isUdapte,
      loading: loading ?? this.loading,
      apiError: apiError ?? this.apiError,
      isUpdate: isUdapte ?? this.isUdapte,
    );
  }

  @override
  List<Object> get props => [
        discotecas,
        discosFavs,
        discosFiltradas,
        getDiscoState,
        getFavDiscoState,
        getDiscoByIdState,
        selectDisco,
        nameFilter,
        provinceFilter,
        cityFilter,
        isUdapte,
        loading,
        apiError,
        isUpdate
      ];
}
