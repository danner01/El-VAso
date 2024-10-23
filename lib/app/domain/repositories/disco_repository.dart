import 'package:either_dart/either.dart';
import '../models/api_error.dart';
import '../models/discoteca_model.dart';

abstract class DiscoRepository {
  Future<Either<ApiError, List<Discoteca>>> getAllDiscos();
  Future<Either<ApiError, Discoteca>> getDiscoById(String id);
  Future<Either<ApiError, String>> updateDisco(Discoteca discoteca);
}
