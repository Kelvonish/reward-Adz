import 'dart:convert';

import 'package:rewardadz/data/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("user", jsonEncode(user));
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = prefs.getString("user");
    var savedUser = UserModel.fromJson(jsonDecode(user));
    return savedUser;
  }

  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool completed = await prefs.remove("user");
    if (completed) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
