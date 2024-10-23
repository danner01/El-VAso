import 'package:either_dart/either.dart';
import 'package:el_vaso/app/domain/models/register_response.dart';
import 'package:el_vaso/app/domain/models/user_model.dart' as user;
import 'package:el_vaso/app/domain/models/verify_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/api_error.dart';
import '../models/login_response.dart';
import '../models/register_social_response.dart';

abstract class AuthRepository {
  Future<Either<CommonError, LoginResponse>> login(
      String email, String password);
  Future<Either<CommonError, RegisterResponse>> register(user.User user);
  Future<Either<CommonError, RegisterSocialResponse>> registerSocial(
      String email, String provider, String avatar);
  Future<Either<CommonError, VerifyResponse>> verify(String email, String code);
  Future<Either<CommonError, VerifyResponse>> verifyEmail(String email);
  Future<Either<CommonError, VerifyResponse>> resendCode(String email);
  Future<Either<CommonError, VerifyResponse>> verifyRecoveryPass(
      String email, String code, String password);
  Future<Either<ApiError, UserCredential>> signInWithGoogle();
  Future<Either<ApiError, UserCredential>> signInWithApple();
  Future<Either<ApiError, UserCredential>> signInWithFacebook();
  Future<Either<CommonError, bool>> verifyToken();
  Future<void> logout();
  Future<Either<CommonError, bool>> deleteAccount();
}
