import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:location/location.dart';

class DetermineLocation {
  bool denied = false;
  LocationData locationData;
  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Fluttertoast.showToast(msg: "User prevented location turn on");
        denied = true;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Fluttertoast.showToast(msg: "Permission denied");
      }
    }

    locationData = await location.getLocation();
    denied = false;

    return locationData;
  }
}
