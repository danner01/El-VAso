part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoad extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final UserProfileBody userProfileBody;

  const UpdateUserEvent(this.userProfileBody);
  @override
  List<Object> get props => [userProfileBody];
}
