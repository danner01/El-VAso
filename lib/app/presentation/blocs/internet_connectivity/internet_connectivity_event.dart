part of 'internet_connectivity_bloc.dart';

abstract class InternetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ConnectedEvent extends InternetEvent {}

class NotConnectedEvent extends InternetEvent {}

class CheckingInternetEvent extends InternetEvent {}
