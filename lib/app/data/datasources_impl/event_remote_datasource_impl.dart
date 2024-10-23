
import 'package:either_dart/either.dart';
import 'package:el_vaso/app/config/http/api.dart';

import 'package:el_vaso/app/domain/models/eventos_model.dart';
import 'package:http/http.dart';
import '../../config/http/urls.dart';
import '../../domain/datasources/event_datasource.dart';
import '../../domain/errors/get_error_from_exception.dart';
import '../../domain/errors/get_left_api_errors.dart';
import '../../domain/errors/set_parse_error_with_log.dart';
import '../../domain/models/api_error.dart';

class EventRemoteDatasourceImpl implements EventDatasource {
  final Api _api;

  EventRemoteDatasourceImpl({required Api api}) : _api = api;

  @override
  Future<Either<ApiError, List<Eventos>>> getAllEventos() async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.get,
        requestName: 'EventsList',
        url: Urls.getAllEvents,
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }
    if (response.statusCode == 200) {
      try {
        final eventResp = Eventos.fromJsonList(response.body);

        return Right(eventResp);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else {
      return Left(getApiError(response));
    }
  }

  @override
  Future<Either<ApiError,String>> createEvent(String id) async {
    late Response response;

    try {
      response = await _api.request(
        httpMethod: HttpMethod.post,
        requestName: 'getEvent',
        url: Urls.createEvent,
        // body: json.encode({"ftoken": fToken}),
      );
    } catch (e) {
      return Left(getErrorFromException(e));
    }

    if (response.statusCode == 200) {
      try {
        final eventResp = response.body;

        return Right(eventResp);
      } catch (e, s) {
        return Left(setParseErrorWithLog(e, s));
      }
    } else {
      return Left(getApiError(response));
    }
  }

}
