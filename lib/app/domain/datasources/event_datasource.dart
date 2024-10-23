import 'package:either_dart/either.dart';
import '../models/api_error.dart';
import '../models/eventos_model.dart';

abstract class EventDatasource {
  Future<Either<ApiError, List<Eventos>>> getAllEventos();
  Future<Either<ApiError,String>> createEvent(String id);
}
