import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:el_vaso/app/config/http/api.dart';
import 'package:http/http.dart';
import '../../config/http/urls.dart';
import '../../domain/datasources/user_datasource.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/errors/get_error_from_exception.dart';
import '../../domain/errors/get_left_api_errors.dart';
import '../../domain/errors/set_parse_error_with_log.dart';
import '../../domain/models/api_error.dart';
import '../../domain/models/user_profile_body.dart';
import '../../domain/models/user_response.dart';


class UserRemoteDatasourceImpl implements UserDatasource {
  final Api _api;

  UserRemoteDatasourceImpl({required Api api}) : _api = api;

  @override
  Future<Either<ApiError, User>> get() async {
    late Response response;

    try {
      response = await  _api.request(
        httpMethod: HttpMethod.get,
        requestName: 'UserMe',
        url: Urls.userMe,
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }
    if (response.statusCode == 200) {
      try {
        final userResp = UserResponse.fromJson(response.body);
        final user = userResp.user;

        return Right(user.copyWith(propertiesNumber: userResp.properties) as User);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else {
      return Left(getApiError(response));
    }
  }

  @override
  Future<Either<ApiError, bool>> updateFToken(String fToken) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'updateFToken',
        url: Urls.updateFToken,
        body: json.encode({"ftoken": fToken}),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    if (response.statusCode == 201) {
      return const Right(true);
    } else {
      return Left(getApiError(response));
    }
  }

  @override
  Future<Either<ApiError, User>> updateUser(
      UserProfileBody userProfileBody) async {
    late Response response;

    try {
      response = await _api.uploadFormData(
        url: Urls.updateUser,
        requestName: 'UpdateUser',
        fieldName: 'file',
        files: userProfileBody.file == null ? null : [userProfileBody.file!],
        fields: userProfileBody.toMap(),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    if (response.statusCode == 201) {
      try {
        final user = User.fromJson(response.body);
        return Right(user);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else {
      return Left(getApiError(response));
    }
  }

  @override
  Future<Either<ApiError, List<User>>> searchByIndentification({
    required String identification,
    required String idType,
  }) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'Search User By Indentification',
        url: Urls.searchUserByIndentification,
        body: json.encode({
          "identification": identification,
          "id_type": idType,
        }),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    if (response.statusCode == 201) {
      try {
        final users = usersFromMap(response.body);
        return Right(users);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else {
      return Left(getApiError(response));
    }
  }
}
