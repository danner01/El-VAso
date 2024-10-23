import 'package:bloc/bloc.dart';
import 'package:el_vaso/app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import '../../../../utilities/enums/api_error_enum.dart';
import '../../../config/injection/injection.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/models/api_error.dart';

import '../../../domain/models/user_profile_body.dart';
import '../../../domain/repositories/user_repository.dart';
import '../internet_connectivity/internet_connectivity_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final InternetConnectivityBloc _internetConnection;

  final _logger = Logger();

  UserBloc({
    required UserRepository userRepository,
    required InternetConnectivityBloc internetConnection,
  })  : _userRepository = userRepository,
        _internetConnection = internetConnection,
        super(const UserState()) {
    on<UserLoad>(_onLoad);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  void _onLoad(UserLoad event, Emitter<UserState> emit) async {
    final isConnection = _checkInternetConnection();

    emit(
      state.copyWith(
          loading: true,
          apiError: const ApiError(apiErrorType: ApiErrorType.none)),
    );
    final resp = await _userRepository.get(isConnection);
    emit(state.copyWith(loading: false));

    resp.either(
      (left) {
        if (left.apiErrorType == ApiErrorType.unauthorized) {
          _logger.e(left.apiErrorType);
          getIt.get<AuthCubit>().logout();
        }
        emit(state.copyWith(apiError: left));
      },
      (right) => emit(state.copyWith(user: right)),
    );
  }

  void _onUpdateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    if (!_checkInternetConnection()) return;

    emit(
      state.copyWith(
          loading: true,
          apiError: const ApiError(apiErrorType: ApiErrorType.none)),
    );
    final resp = await _userRepository.updateUser(event.userProfileBody);
    emit(state.copyWith(loading: false));

    resp.either((left) {
      if (left.apiErrorType == ApiErrorType.unauthorized) {
        _logger.e(left.apiErrorType);
          getIt.get<AuthCubit>().logout();
      }
      emit(state.copyWith(apiError: left));
    }, (right) {
      emit(state.copyWith(user: right, isUdapte: true));
      emit(state.copyWith(isUdapte: false));
    });
  }

  bool _checkInternetConnection() {
    _internetConnection.add(CheckingInternetEvent());
    return _internetConnection.state == InternetConnectivityState.connected;
  }
}
