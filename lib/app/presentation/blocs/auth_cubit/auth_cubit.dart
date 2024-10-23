import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:el_vaso/app/domain/models/api_error.dart';
import 'package:el_vaso/app/domain/models/user_model.dart';
import 'package:el_vaso/app/domain/repositories/auth_repository.dart';
import 'package:el_vaso/app/presentation/blocs/internet_connectivity/internet_connectivity_bloc.dart';
import 'package:el_vaso/utilities/enums/api_error_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../utilities/enums/login_state_enum.dart';
import '../../../config/local_storage/local_storage.dart';
import '../../../domain/models/login_response.dart';
import '../../../domain/models/register_social_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with ChangeNotifier {
  final AuthRepository _authRepository;
  final LocalStorage _localStorage;
  final InternetConnectivityBloc _internetConnection;

  AuthCubit({
    required InternetConnectivityBloc internetConnection,
    required AuthRepository authRepository,
    required LocalStorage localStorage,
  })  : _internetConnection = internetConnection,
        _authRepository = authRepository,
        _localStorage = localStorage,
        super(const AuthState()) {
    onCheck();
  }

  void onCheck() async {
    emit(state.copyWith(commonError: const ApiError()));

    if (_localStorage.token.isEmpty) {
      emit(state.copyWith(loginState: LoginState.noAuth));
    } else {
      emit(state.copyWith(loginState: LoginState.success));
      // final resp = await _authRepository.verifyToken();
      // resp.either(
      //   (left) {
      //     emit(
      //       state.copyWith(commonError: left, loginState: LoginState.noAuth),
      //     );
      //     notifyListeners();
      //   },
      //   (right) => emit(
      //     state.copyWith(
      //       loginState: LoginState.success,
      //       user: User.fromJson(_localStorage.user),
      //     ),
      //   ),
      // );
    }
  }

///////////////////////////////////////////////////
///////////////////////////////////////////////////////
  void login(String email, String password) async {
    emit(state.copyWith(
      loginState: LoginState.loading,
      commonError: const ApiError(),
    ));

    final resp = await _authRepository.login(email, password);

    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          loginState: LoginState.error,
        ),
      ),
      (right) async {
        _saveTokenAndUserInLocalStorage(right);

        emit(state.copyWith(
          loginState: LoginState.success,
          user: right.user,
        ));

        resp.either(
          (left) {
            log('Error al autenticar el usuario en la BD: ${left.errorMsg}');
          },
          (right) {
            log('Se autenticó correctamente el colector en la BD: ${right.message}');
          },
        );
      },
    );
  }

////////////////////////////////////////////////////////////////////////////////////////
  void register(User user) async {
    emit(state.copyWith(
      registerState: RegisterState.loading,
      commonError: const ApiError(),
    ));

    log('PEPEPEPE:${user.toJson()}');
    final resp = await _authRepository.register(user);

    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          registerState: RegisterState.error,
        ),
      ),
      (right) async {
        _localStorage.user = user.toJson();
        emit(state.copyWith(
          registerState: RegisterState.success,
        ));
      },
    );
////////////////////////////////////////////////////////////////////////////////////////
    resp.either(
      (left) {
        log('Error al registrar el usuario: ${left.errorMsg}');
      },
      (right) {
        log('Se registró correctamente el usuario: $right');
      },
    );
  }

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
  void registerSocial(User user, String social) async {
    emit(state.copyWith(
      registerSocialState: RegisterSocialState.loading,
      commonError: const ApiError(),
    ));

    final resp =
        await _authRepository.registerSocial(user.email, social, user.avatar!);
    // log('PEPEPEPE:${resp}')

    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          registerSocialState: RegisterSocialState.error,
        ),
      ),
      (right) async {
        final RegisterSocialResponse registerResponsive =
            RegisterSocialResponse(
          accessToken: right.accessToken!,
          user: User(email: right.user!.email, avatar: right.user!.avatar),
        );
        log('Firebase Auth Token:$registerResponsive');

        _saveTokenFirebaseInLocalStorage(registerResponsive);

        emit(state.copyWith(
            registerSocialState: RegisterSocialState.success,
            user: User(email: right.user!.email, avatar: right.user!.avatar)));
      },
    );
////////////////////////////////////////////////////////////////////////////////////////
    resp.either(
      (left) {
        log('Error al registrar el usuario: ${left.errorMsg}');
      },
      (right) {
        log('Se registró correctamente el usuario: $right');
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
  void resendCode(String email) async {
    emit(state.copyWith(
      resendState: ResendState.loading,
      commonError: const ApiError(),
    ));

    final resp = await _authRepository.resendCode(email);
    // log('PEPEPEPE:${resp}');
    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          resendState:ResendState.error,
        ),
      ),
      (right) async {
        // _saveTokenAndUserInLocalStorage(right);
        emit(state.copyWith(
          resendState: ResendState.success,
        ));
      },
    );
    resp.either(
      (left) {
        log('Error al reenviar el Código: ${left.errorMsg}');
      },
      (right) {
        log('Se verificó correctamente el email: $right');
      },
    );
  }

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
  void verify(String email, String code) async {
    emit(state.copyWith(
      verifyState: VerifyState.loading,
      commonError: const ApiError(),
    ));

    final resp = await _authRepository.verify(email, code);
    // log('PEPEPEPE:${resp}');
    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          verifyState: VerifyState.error,
        ),
      ),
      (right) async {
        // _saveTokenAndUserInLocalStorage(right);
        emit(state.copyWith(
          verifyState: VerifyState.success,
        ));
      },
    );
////////////////////////////////////////////////////////////////////////////////////////
    resp.either(
      (left) {
        log('Error al verificar el usuario: ${left.errorMsg}');
      },
      (right) {
        log('Se verificó correctamente el usuario: $right');
      },
    );
  }

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
  void verifyEmail(String email) async {
    emit(state.copyWith(
      verifyRecoveryState: VerifyRecoveryState.loading,
      commonError: const ApiError(),
    ));

    final resp = await _authRepository.verifyEmail(email);
    // log('PEPEPEPE:${resp}');
    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          verifyRecoveryState: VerifyRecoveryState.error,
        ),
      ),
      (right) async {
        // _saveTokenAndUserInLocalStorage(right);
        emit(state.copyWith(
          verifyRecoveryState: VerifyRecoveryState.success,
        ));
      },
    );
    resp.either(
      (left) {
        log('Error al verificar el email: ${left.errorMsg}');
      },
      (right) {
        log('Se verificó correctamente el email: $right');
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
  void verifyRecoveryPass(String email, String code, String password) async {
    emit(state.copyWith(
      verifyRecoveryState: VerifyRecoveryState.loading,
      commonError: const ApiError(),
    ));

    final resp =
        await _authRepository.verifyRecoveryPass(email, code, password);
    // log('PEPEPEPE:${resp}');
    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          verifyRecoveryState: VerifyRecoveryState.error,
        ),
      ),
      (right) async {
        // _saveTokenAndUserInLocalStorage(right);
        emit(state.copyWith(
          verifyRecoveryState: VerifyRecoveryState.success,
        ));
      },
    );
    resp.either(
      (left) {
        log('Error al verificar el password: ${left.errorMsg}');
      },
      (right) {
        log('Se verificó correctamente el password: $right');
      },
    );
  }

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
  void signInWithFacebook() async {
    emit(state.copyWith(
      loginState: LoginState.loading,
      commonError: const ApiError(),
    ));

    final resp = await _authRepository.signInWithFacebook();

    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          loginState: LoginState.error,
        ),
      ),
      (right) async {
        // final LoginResponse loginResponsive = LoginResponse(
        //   accessToken: right.credential!.accessToken!,
        //   user: User(email: right.user!.email!),
        // );

        // _saveTokenFirebaseInLocalStorage(loginResponsive);

        emit(state.copyWith(
          loginState: LoginState.success,
          user: User(email: right.user!.email!, avatar: right.user!.photoURL),
        ));

        resp.either(
          (left) {
            log('Error al loguiar el usuario con Facebook: ${left.errorMsg}');
          },
          (right) {
            log('Se autenticó correctamente con Facebook el usuario: ${right.user?.email}');
          },
        );
      },
    );
  }

///////////////////////////////////////////////////////
  void signInWithApple() async {
    emit(state.copyWith(
      loginState: LoginState.loading,
      commonError: const ApiError(),
    ));

    final resp = await _authRepository.signInWithApple();

    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          loginState: LoginState.error,
        ),
      ),
      (right) async {
        // final LoginResponse loginResponsive = LoginResponse(
        //   accessToken: right.credential!.accessToken!,
        //   user: User(email: right.user!.email!),
        // );
        // log('Firebase Auth Token:${right.credential?.accessToken}');

        // _saveTokenFirebaseInLocalStorage(loginResponsive);

        emit(state.copyWith(
          loginState: LoginState.success,
          user: User(email: right.user!.email!),
        ));

        resp.either(
          (left) {
            log('Error al loguiar el usuario con Apple: ${left.errorMsg}');
          },
          (right) {
            log('Se autenticó correctamente con Apple el usuario: ${right.user?.email}');
          },
        );
      },
    );
  }

///////////////////////////////////////////////////////
  void signInWithGoogle() async {
    emit(state.copyWith(
      loginState: LoginState.loading,
      commonError: const ApiError(),
    ));

    final resp = await _authRepository.signInWithGoogle();

    resp.either(
      (left) => emit(
        state.copyWith(
          commonError: left,
          loginState: LoginState.error,
        ),
      ),
      (right) async {
        // final LoginResponse loginResponsive = LoginResponse(
        //   accessToken: right.credential!.accessToken!,
        //   user: User(email: right.user!.email!, avatar: right.user!.photoURL),
        // );

        // _saveTokenFirebaseInLocalStorage(loginResponsive);
        registerSocial(
            User(email: right.user!.email!, avatar: right.user!.photoURL),
            'google');

        // emit(state.copyWith(
        //   loginState: LoginState.success,
        //   user: User(email: right.user!.email!),
        // ));

        resp.either(
          (left) {
            log('Error al loguiar el usuario con Google: ${left.errorMsg}');
          },
          (right) {
            log('Se autenticó correctamente con Goolge el usuario: ${right.user?.email}');
          },
        );
      },
    );
  }

  //////////////////////////////////////////////////////
  void logout() async {
    _localStorage.token = '';
    _localStorage.user = '';
    emit(state.copyWith(loginState: LoginState.noAuth));
    notifyListeners();
  }

  void _saveTokenAndUserInLocalStorage(LoginResponse response) {
    _localStorage.token = response.accessToken;
    _localStorage.user = response.user.toJson();
  }

  void _saveTokenFirebaseInLocalStorage(RegisterSocialResponse response) {
    _localStorage.fToken = response.accessToken!;
    _localStorage.user = response.user!.toJson();
  }

  bool _checkInternetConnection() {
    _internetConnection.add(CheckingInternetEvent());
    return _internetConnection.state == InternetConnectivityState.connected;
  }

  void isUnauthorized(CommonError left) {
    if (left is ApiError && left.apiErrorType == ApiErrorType.unauthorized) {
      logout();
    }
  }
}
