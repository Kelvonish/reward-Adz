import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceDetails {
  Future<String> getDeviceInfo() async {
    String deviceName;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.model;
    }

    return deviceName;
  }
}
