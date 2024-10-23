import 'package:either_dart/either.dart';

import '../../../utilities/enums/api_error_enum.dart';
import '../../config/local_storage/local_storage.dart';
import '../../domain/datasources/user_datasource.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/models/api_error.dart';
import '../../domain/models/user_profile_body.dart';


class UserLocalDatasourceImpl implements UserDatasource {
  final LocalStorage _localStorage;

  UserLocalDatasourceImpl({required LocalStorage localStorage})
      : _localStorage = localStorage;

  @override
  Future<Either<ApiError, User>> get() async {
    try {
      final User user = User.fromJson(_localStorage.user);
      return Right(user);
    } catch (e) {
      return const Left(ApiError(apiErrorType: ApiErrorType.parseError));
    }
  }

  @override
  Future<Either<ApiError, bool>> updateFToken(String fToken) {
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiError, User>> updateUser(UserProfileBody userProfileBody) {
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiError, List<User>>> searchByIndentification({
    required String identification,
    required String idType,
  }) {
    throw UnimplementedError();
  }
}
