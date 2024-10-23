import 'package:either_dart/either.dart';


import '../entities/user_entity.dart';
import '../models/api_error.dart';
import '../models/user_profile_body.dart';

abstract class UserRepository {
  Future<Either<ApiError, User>> get(bool isOnline);
  Future<Either<ApiError, bool>> updateFToken(String fToken);
  Future<Either<ApiError, User>> updateUser(UserProfileBody userProfileBody);
  Future<Either<ApiError, List<User>>> searchByIndentification({
    required String identification,
    required String idType,
  });
}
