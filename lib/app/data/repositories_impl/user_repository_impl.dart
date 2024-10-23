import 'package:either_dart/either.dart';

import '../../config/local_storage/local_storage.dart';
import '../../domain/datasources/user_datasource.dart';


import '../../domain/entities/user_entity.dart';
import '../../domain/models/api_error.dart';
import '../../domain/models/user_profile_body.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalStorage _localStorage;
  final UserDatasource _userRemoteDatasource;
  final UserDatasource _userLocalDatasource;
  // final _localStorage = LocalStorage();

  UserRepositoryImpl(
      {required LocalStorage localStorage,
      required UserDatasource userRemoteDatasource,
      required UserDatasource userLocalDatasource})
      : _localStorage = localStorage,
        _userRemoteDatasource = userRemoteDatasource,
        _userLocalDatasource = userLocalDatasource;

  @override
  Future<Either<ApiError, User>> get(bool isOnline) async {
    if (isOnline) {
      final resp = await _userRemoteDatasource.get();
      resp.either((left) {}, (right) => _saveUserInLocalStorage(right));
      return resp;
    }
    return _userLocalDatasource.get();
  }

  void _saveUserInLocalStorage(User user) {
    _localStorage.user = user.toJson();
  }

  @override
  Future<Either<ApiError, bool>> updateFToken(String fToken) {
    return _userRemoteDatasource.updateFToken(fToken);
  }

  @override
  Future<Either<ApiError, User>> updateUser(UserProfileBody userProfileBody) {
    return _userRemoteDatasource.updateUser(userProfileBody);
  }

  @override
  Future<Either<ApiError, List<User>>> searchByIndentification({
    required String identification,
    required String idType,
  }) {
    return _userRemoteDatasource.searchByIndentification(
      identification: identification,
      idType: idType,
    );
  }
}
