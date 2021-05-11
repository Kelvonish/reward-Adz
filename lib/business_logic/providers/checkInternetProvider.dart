import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class IntenetProvider extends ChangeNotifier {
  String connection;
  var subcriprion =
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
    } else if (result == ConnectivityResult.none) {}
  });
}
