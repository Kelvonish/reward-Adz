import 'dart:io';

import 'package:connectivity/connectivity.dart';


import 'dart:async';

enum ConnectivityStatus { WiFi, Cellular, Offline }

class ConnectivityService {
  // Create our public controller
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else {
      return false;
    }
    return false;
  }
}
