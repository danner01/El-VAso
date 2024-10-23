import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_connectivity_event.dart';
part 'internet_connectivity_state.dart';

class InternetConnectivityBloc
    extends Bloc<InternetEvent, InternetConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription? _subscription;

  InternetConnectivityBloc({required Connectivity connectivity})
      : _connectivity = connectivity,
        super(InternetConnectivityState.initial) {

    on<InternetEvent>((event, emit)  async {
      
       var connectivityResult = await (Connectivity().checkConnectivity());

     if (connectivityResult == ConnectivityResult.none) {
      emit(InternetConnectivityState.noInternet);
    } else if (connectivityResult == ConnectivityResult.mobile) {
      emit(InternetConnectivityState.connected);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      emit(InternetConnectivityState.connected);
    } else {
      emit(InternetConnectivityState.noConnected);
    }
    });

    // on<CheckingInternetEvent>(_checkInternetConnectivity);
    on<CheckingInternetEvent>(_onChecking);

    _subscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        add(ConnectedEvent());
      } else {
        add(NotConnectedEvent());
      }
    });
  }

  void _onChecking(
      CheckingInternetEvent event, Emitter<InternetConnectivityState> emit) {
    final isNotConnection = state == InternetConnectivityState.noConnected ||
        state == InternetConnectivityState.initial;
    if (isNotConnection) {
      emit(InternetConnectivityState.checking);
      emit(InternetConnectivityState.noConnected);
    }
  }

  
bool checkInternet() {
    add(CheckingInternetEvent());

    final isNotConnection = state == InternetConnectivityState.noConnected ||
        state == InternetConnectivityState.initial;

    if (isNotConnection) add(NotConnectedEvent());

    return isNotConnection;
  }
  
  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
