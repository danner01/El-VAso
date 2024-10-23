import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:el_vaso/app/domain/datasources/auth_datasource.dart';
import 'package:el_vaso/app/domain/errors/get_error_from_exception.dart';
import 'package:el_vaso/app/domain/errors/get_left_api_errors.dart';
import 'package:el_vaso/app/domain/errors/set_parse_error_with_log.dart';
import 'package:el_vaso/app/domain/models/api_error.dart';
import 'package:el_vaso/app/domain/models/login_response.dart';
import 'package:el_vaso/app/domain/models/register_response.dart';
import 'package:el_vaso/app/domain/models/user_model.dart' as user;
import 'package:el_vaso/app/domain/models/verify_response.dart';
import 'package:el_vaso/utilities/enums/api_error_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../config/http/api.dart';
import '../../config/http/urls.dart';
import '../../domain/models/register_social_response.dart';

class AuthRemoteDatasourceImpl implements AuthDataSource {
  final Api _api;
  final _auth = FirebaseAuth.instance;
  final _logger = Logger(level: Level.nothing);

  AuthRemoteDatasourceImpl(this._api);

////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<Either<CommonError, LoginResponse>> login(
      String email, String password) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'Login in backend',
        url: Urls.login,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    if (response.statusCode == 201) {
      final loginResponse = LoginResponse.fromJson(response.body);
      try {
        return Right(loginResponse);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else if (response.statusCode == 401) {
      return const Left(
          ApiError(apiErrorType: ApiErrorType.emailOrPassowordIcorrect));
    } else {
      return Left(getApiError(response));
    }
  }
////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<CommonError, RegisterResponse>> register(user.User user) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'Register in backend',
        url: Urls.register,
        body: jsonEncode({
          "email": user.email,
          "password": user.password,
          "name": user.name,
          "lastname": user.lastname,
          "username": user.username,
          "birthdate": user.birthdate!.toIso8601String(),
          "gender": user.gender,
          "postalCode": user.postalCode,
          "dniNumber": user.dniNumber,
          "passportNumber": user.passportNumber,
          "phoneNumber": user.phoneNumber
        }),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    final registerResponse = RegisterResponse.fromJson(response.body);

    if (response.statusCode == 201) {
      try {
        return Right(registerResponse);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else if (response.statusCode == 400) {
      return const Left(
          ApiError(apiErrorType: ApiErrorType.passwordIsNotStron));
    } else {
      return Left(getApiError(response));
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<CommonError, RegisterSocialResponse>> registerSocial(
      String email, String provider, String avatar) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'Register in backend',
        url: Urls.registerSocial,
        body:  jsonEncode({"email": email, "provider": provider, "avatar": avatar}),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }
    final registerResponse = RegisterSocialResponse.fromJson(response.body);

    if (response.statusCode == 201) {
      try {
        return Right(registerResponse);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else if (response.statusCode == 401) {
      return const Left(
          ApiError(apiErrorType: ApiErrorType.emailOrPassowordIcorrect));
    } else {
      return Left(getApiError(response));
    }
  }
////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<CommonError, VerifyResponse>> verify(
      String email, String code) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'Verify in backend',
        url: Urls.velidate,
        body: jsonEncode({
          "email": email,
          "verificationCode": code,
        }),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    final verifyResponse = VerifyResponse.fromJson(response.body);

    if (response.statusCode == 201) {
      try {
        return Right(verifyResponse);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else if (response.statusCode == 401) {
      return const Left(
          ApiError(apiErrorType: ApiErrorType.emailOrPassowordIcorrect));
    } else {
      return Left(getApiError(response));
    }
  }
   ////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<CommonError, VerifyResponse>> resendCode(
      String email) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'Verify in backend',
        url: Urls.resendCode,
        body: jsonEncode({
          "email": email,
        }),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    final verifyResponse = VerifyResponse.fromJson(response.body);

    if (response.statusCode == 201) {
      try {
        return Right(verifyResponse);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else if (response.statusCode == 401) {
      return const Left(
          ApiError(apiErrorType: ApiErrorType.emailOrPassowordIcorrect));
    } else {
      return Left(getApiError(response));
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<CommonError, VerifyResponse>> verifyEmail(String email) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'Verify in backend',
        url: Urls.verifyEmail,
        body: jsonEncode({
          "email": email,
        }),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    final verifyResponse = VerifyResponse.fromJson(response.body);

    if (response.statusCode == 201) {
      try {
        return Right(verifyResponse);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else if (response.statusCode == 401) {
      return const Left(
          ApiError(apiErrorType: ApiErrorType.emailOrPassowordIcorrect));
    } else {
      return Left(getApiError(response));
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<CommonError, VerifyResponse>> verifyRecoveryPass(
      String email, String code, String password) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'Verify in backend',
        url: Urls.verifyRecoveryPass,
        body: jsonEncode({
          "email": email,
          "verificationCode": code,
          "password": password,
        }),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    final verifyResponse = VerifyResponse.fromJson(response.body);

    if (response.statusCode == 201) {
      try {
        return Right(verifyResponse);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else if (response.statusCode == 401) {
      return const Left(
          ApiError(apiErrorType: ApiErrorType.emailOrPassowordIcorrect));
    } else {
      return Left(getApiError(response));
    }
  }
////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<CommonError, bool>> verifyToken() async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'Verfiy Token in backend',
        url: Urls.verifyToken,
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    if (response.statusCode == 201) {
      return const Right(true);
    } else if (response.statusCode == 401) {
      return const Left(
        ApiError(errorMsg: 'Su sesión ha expirado, debe loguearse nuevamente.'),
      );
    } else {
      return Left(getApiError(response));
    }
  }
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<ApiError, UserCredential>> signInWithFacebook() async {
    final facebookAuth = await FacebookAuth.instance.login();
    // final result = await facebookAuth.login();
    log('Google Auth: $facebookAuth');

    final oAuthCredential =
        FacebookAuthProvider.credential(facebookAuth.accessToken!.tokenString);

    try {
      final user = await _auth.signInWithCredential(oAuthCredential);
      _logger.i('SignInWithFacebook user: $user');
      return Right(user);
    } catch (e) {
      _logger.e('SignInWithFacebook error: $e');
      return Left(ApiError(
          apiErrorType: ApiErrorType.unknownError, errorMsg: e.toString()));
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<Either<ApiError, UserCredential>> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return const Left(
          ApiError(apiErrorType: ApiErrorType.unknownError, errorMsg: ''));
    }
    GoogleSignInAuthentication? googleAuth;

    try {
      googleAuth = await googleUser.authentication;
    } catch (e) {
      _logger.e('GoogleSignIn error: $e');
      return Left(ApiError(
          apiErrorType: ApiErrorType.unknownError, errorMsg: e.toString()));
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    log('Google Auth: $credential');

    try {
      final user = await _auth.signInWithCredential(credential);
      // Obtiene el Firebase ID Token del usuario autenticado.
      //String? idToken = await user.user?.getIdToken();
      // log('Firebase ID Token: $idToken');
      _logger.i('SignInWithGoogle user: $user');
      return Right(user);
    } catch (e) {
      _logger.e('SignInWithGoogle error: $e');
      return Left(ApiError(
          apiErrorType: ApiErrorType.unknownError, errorMsg: e.toString()));
    }
  }
////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<ApiError, UserCredential>> signInWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // final credential = OAuthProvider('apple.com').credential(
    //   idToken: appleIdCredential.identityToken,
    //   accessToken: appleIdCredential.authorizationCode,
    // );
    AppleAuthProvider appleProvider = AppleAuthProvider();

    // add required 'email' scope
    appleProvider = appleProvider.addScope('email');
// add optional 'name' scope
    appleProvider = appleProvider.addScope('name');

    try {
      // final user = await _auth.signInWithCredential(credential);
      final user = await _auth.signInWithProvider(appleProvider);
      return Right(user);
    } catch (e) {
      _logger.e('signInWithApple error: $e');
      return Left(
        ApiError(
            apiErrorType: ApiErrorType.unknownError, errorMsg: e.toString()),
      );
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  @override
  Future<Either<ApiError, bool>> deleteAccount() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await user.delete();
        return const Right(true);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          return const Right(false);
        }
        return const Left(
          ApiError(
              apiErrorType: ApiErrorType.unknownError,
              errorMsg: 'Error al intentar eliminar la cuenta'),
        );
      }
    } else {
      return const Right(false);
    }
  }
}
