import 'package:either_dart/either.dart';
import '../../domain/datasources/disco_datasource.dart';
import '../../domain/models/api_error.dart';
import '../../domain/models/discoteca_model.dart';
import '../../domain/repositories/disco_repository.dart';

class DiscoRepositoryImpl implements DiscoRepository {
  final DiscoDatasource _discoRemoteDatasource;
  // final _localStorage = LocalStorage();

  DiscoRepositoryImpl({required DiscoDatasource discoRemoteDatasource})
      : _discoRemoteDatasource = discoRemoteDatasource;

  @override
  Future<Either<ApiError, List<Discoteca>>> getAllDiscos() async {
    return _discoRemoteDatasource.getAllDiscos();
  }

  @override
  Future<Either<ApiError, Discoteca>> getDiscoById(String id) {
    return _discoRemoteDatasource.getDiscoById(id);
  }

  @override
  Future<Either<ApiError, String>> updateDisco(Discoteca discoteca) {
    return _discoRemoteDatasource.updateDisco(discoteca);
  }
}
