import 'package:either_dart/either.dart';
import '../../domain/datasources/event_datasource.dart';
import '../../domain/models/api_error.dart';
import '../../domain/models/eventos_model.dart';
import '../../domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDatasource _eventRemoteDatasource;
  // final _localStorage = LocalStorage();

  EventRepositoryImpl({required EventDatasource eventRemoteDatasource})
      : _eventRemoteDatasource = eventRemoteDatasource;

  @override
  Future<Either<ApiError, List<Eventos>>> getAllEventos() async {
    return _eventRemoteDatasource.getAllEventos();
  }

  @override
  Future<Either<ApiError, String>> createEvent(String id) {
    return _eventRemoteDatasource.createEvent(id);
  }
}
