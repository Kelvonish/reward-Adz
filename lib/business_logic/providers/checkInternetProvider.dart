import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

import 'dart:async';

enum ConnectivityStatus { WiFi, Cellular, Offline }

class ConnectivityService {
  // Create our public controller
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
