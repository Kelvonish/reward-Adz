import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internetcubit_state.dart';

class InternetcubitCubit extends Cubit<InternetcubitState> {
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSubcription;
  InternetcubitCubit({@required this.connectivity})
      : super(InternetcubitInitial()) {
    connectivityStreamSubcription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected();
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected() => emit(InternetConnected());
  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubcription.cancel();
    return super.close();
  }
}
