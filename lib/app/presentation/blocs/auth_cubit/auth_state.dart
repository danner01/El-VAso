part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final LoginState loginState;
  final RegisterState registerState;
  final RegisterSocialState registerSocialState;
  final VerifyState verifyState;
  final ResendState resendState;
  final VerifyRecoveryState verifyRecoveryState;
  final CommonError commonError;
  final User user;

  const AuthState({
    this.loginState = LoginState.cheking,
    this.registerState = RegisterState.cheking,
    this.registerSocialState = RegisterSocialState.cheking,
    this.verifyState = VerifyState.cheking,
    this.resendState = ResendState.cheking,
    this.verifyRecoveryState = VerifyRecoveryState.cheking,
    this.commonError = const ApiError(),
    this.user = const User(email: ''),
  });

  AuthState copyWith({
    LoginState? loginState,
    RegisterState? registerState,
    RegisterSocialState? registerSocialState,
    VerifyState? verifyState,
    ResendState? resendState,
    VerifyRecoveryState? verifyRecoveryState,
    CommonError? commonError,
    User? user,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      registerSocialState: registerSocialState ?? this.registerSocialState,
      registerState: registerState ?? this.registerState,
      verifyState: verifyState ?? this.verifyState,
      resendState: resendState ?? this.resendState,
      verifyRecoveryState: verifyRecoveryState ?? this.verifyRecoveryState,
      commonError: commonError ?? this.commonError,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [
        loginState,
        registerState,
        registerSocialState,
        verifyState,
        resendState,
        verifyRecoveryState,
        commonError,
        user
      ];
}
