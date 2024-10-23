import 'package:either_dart/either.dart';
import 'package:el_vaso/app/domain/datasources/auth_datasource.dart';
import 'package:el_vaso/app/domain/models/api_error.dart';
import 'package:el_vaso/app/domain/models/login_response.dart';
import 'package:el_vaso/app/domain/models/register_response.dart';
import 'package:el_vaso/app/domain/models/user_model.dart' as user;
import 'package:el_vaso/app/domain/models/verify_response.dart';
import 'package:el_vaso/app/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/register_social_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authRemoteDataSource;
  // final AuthDataSource _AuthLocalDataSource;

  AuthRepositoryImpl({
    required AuthDataSource authRemoteDataSource,
    // required ListerosDataSource listerosLocalDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;
  // _listerosLocalDataSource = listerosLocalDataSource;

  @override
  Future<Either<CommonError, LoginResponse>> login(
      String email, String password) {
    return _authRemoteDataSource.login(email, password);
  }

  @override
  Future<Either<CommonError, RegisterResponse>> register(user.User user) {
    return _authRemoteDataSource.register(user);
  }

  @override
  Future<Either<CommonError, RegisterSocialResponse>> registerSocial(
      String email, String provider, String avatar) {
    return _authRemoteDataSource.registerSocial(email, provider, avatar);
  }

  @override
  Future<Either<CommonError, VerifyResponse>> resendCode(String email) {
    return _authRemoteDataSource.resendCode(email);
  }

  @override
  Future<Either<CommonError, VerifyResponse>> verifyEmail(String email) {
    return _authRemoteDataSource.verifyEmail(email);
  }

  @override
  Future<Either<CommonError, VerifyResponse>> verifyRecoveryPass(
      String email, String code, String password) {
    return _authRemoteDataSource.verifyRecoveryPass(email, code, password);
  }
  

  @override
  Future<Either<CommonError, VerifyResponse>> verify(
      String email, String code) {
    return _authRemoteDataSource.verify(email, code);
  }

  @override
  Future<Either<ApiError, UserCredential>> signInWithGoogle() {
    return _authRemoteDataSource.signInWithGoogle();
  }

  @override
  Future<Either<ApiError, UserCredential>> signInWithApple() {
    return _authRemoteDataSource.signInWithApple();
  }

  @override
  Future<Either<ApiError, UserCredential>> signInWithFacebook() {
    return _authRemoteDataSource.signInWithFacebook();
  }

  @override
  Future<Either<CommonError, bool>> verifyToken() {
    return _authRemoteDataSource.verifyToken();
  }

  @override
  Future<void> logout() {
    return _authRemoteDataSource.logout();
  }

  @override
  Future<Either<ApiError, bool>> deleteAccount() {
    return _authRemoteDataSource.deleteAccount();
  }
}
