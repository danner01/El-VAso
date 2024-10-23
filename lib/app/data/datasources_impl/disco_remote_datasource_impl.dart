import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:el_vaso/app/config/http/api.dart';
import 'package:el_vaso/app/domain/models/discoteca_model.dart';
import 'package:http/http.dart';
import '../../../utilities/enums/api_error_enum.dart';
import '../../config/http/urls.dart';
import '../../domain/datasources/disco_datasource.dart';
import '../../domain/errors/get_error_from_exception.dart';
import '../../domain/errors/get_left_api_errors.dart';
import '../../domain/errors/set_parse_error_with_log.dart';
import '../../domain/models/api_error.dart';

class DiscoRemoteDatasourceImpl implements DiscoDatasource {
  final Api _api;

  DiscoRemoteDatasourceImpl({required Api api}) : _api = api;

  @override
  Future<Either<ApiError, List<Discoteca>>> getAllDiscos() async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'DiscoList',
        url: Urls.getAllDisc,
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }
    if (response.statusCode == 200) {
      try {
        
        final discoResp = Discoteca.fromJsonList(response.body);

        return Right(discoResp);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else if (response.statusCode == 401) {
      return const Left(
          ApiError(apiErrorType: ApiErrorType.unauthorized));
    } else {
      return Left(getApiError(response));
    }
  }

  @override
  Future<Either<ApiError, Discoteca>> getDiscoById(String id) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.get,
        requestName: 'discoById',
        url: '${Urls.discById}/$id',
        // body: json.encode({"ftoken": fToken}),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    if (response.statusCode == 200) {
      try {
        final discoResp = Discoteca.fromJson(response.body);

        return Right(discoResp);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else {
      return Left(getApiError(response));
    }
  }

  @override
  Future<Either<ApiError, String>> updateDisco(Discoteca discoteca) async {
    late Response response;

    try {
      response = await _api.request(
          url: Urls.updateDisco,
          requestName: 'UpdateDisco',
          body: json.encode(discoteca));
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    if (response.statusCode == 201) {
      try {
        // final disco = User.fromJson(response.body);
        return Right('Disco Update');
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else {
      return Left(getApiError(response));
    }
  }
}
