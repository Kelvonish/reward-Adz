import 'package:location/location.dart';
import 'package:rewardadz/business_logic/Shared/getLocation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocationPreference {
  saveLocation() async {
    LocationData location = await DetermineLocation().getLocation();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("latitude", location.latitude.toString());
    prefs.setString("longitude", location.longitude.toString());
  }

  getLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String latitude = prefs.getString("latitude");
    String longitude = prefs.getString("longitude");

    return [latitude, longitude];
  }

  removeLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("latitude");
    await prefs.remove("longitude");
  }
}
