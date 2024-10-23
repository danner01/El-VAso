import 'package:either_dart/either.dart';
import 'package:el_vaso/app/domain/models/eventos_model.dart';
import '../models/api_error.dart';

abstract class EventRepository {
  Future<Either<ApiError, List<Eventos>>> getAllEventos();
  Future<Either<ApiError, String>> createEvent(String id);
}
