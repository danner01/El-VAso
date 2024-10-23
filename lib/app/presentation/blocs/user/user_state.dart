part of 'user_bloc.dart';

const initialUser = User(
  name: '',
  email: '',
);

class UserState extends Equatable {
  final User user;
  final bool isUdapte;
  final bool loading;
  final ApiError apiError;
  final bool isUpdate;

  const UserState({
    this.user = initialUser,
    this.isUdapte = false,
    this.loading = false,
    this.apiError = const ApiError(apiErrorType: ApiErrorType.none),
    this.isUpdate = false,
  });

  UserState copyWith({
    User? user,
    bool? isUdapte,
    bool? loading,
    ApiError? apiError,
    bool? isUpdate,
  }) {
    return UserState(
      user: user ?? this.user,
      isUdapte: isUdapte ?? this.isUdapte,
      loading: loading ?? this.loading,
      apiError: apiError ?? this.apiError,
      isUpdate: isUdapte ?? this.isUdapte,
    );
  }

  @override
  List<Object> get props => [user, isUdapte, loading, apiError, isUpdate];
}
