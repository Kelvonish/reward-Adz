import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/userModel.dart';

class UserNetworkService {
  Future<UserModel> createUser(UserModel user) async {
    Map data = {
      'email': user.data.email,
      "password": user.data.password,
      "phone": user.data.phone,
      "country": user.data.country,
      "type": user.data.type
    };

    try {
      String url = BASE_URL + "users/mobile/levelone/new";
      var body = json.encode(data);
      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return UserModel.fromJson(returnedData);
      } else {
        if (returnedData['message'] == 'duplicates found')
          Fluttertoast.showToast(
              msg: 'User registered with email or phone number already exists');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
    return null;
  }

  Future<UserModel> createSocialUser(UserModel user) async {
    Map data = {
      'email': user.data.email,
      "type": user.data.type,
      "phone": user.data.phone,
      "country": user.data.country,
    };

    try {
      String url = BASE_URL + "users/mobile/levelone/new";
      var body = json.encode(data);
      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return UserModel.fromJson(returnedData);
      } else {
        if (returnedData['message'] == 'duplicates found')
          Fluttertoast.showToast(
              msg: 'User registered with email or phone number already exists');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
    return null;
  }

  Future<UserModel> addUserDetails(UserModel user) async {
    Map data = {
      'firstname': user.data.fname,
      "lastname": user.data.lname,
      "gender": user.data.gender,
      "dob": user.data.dob,
      "id": user.data.id
    };

    try {
      String url = BASE_URL + "users/mobile/leveltwo/new";
      var body = json.encode(data);
      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return UserModel.fromJson(returnedData);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
    return null;
  }

  Future<UserModel> loginUser(UserModel user) async {
    Map data = {
      'email': user.data.email,
      "password": user.data.password,
      'type': user.data.type
    };

    try {
      String url = BASE_URL + "signinmobile";
      var body = json.encode(data);
      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return UserModel.fromJson(returnedData);
      } else {
        if (returnedData['data'] is String) {
          Fluttertoast.showToast(msg: returnedData['data']);
        } else if (returnedData['message'] is String) {
          Fluttertoast.showToast(msg: returnedData['message']);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Nothing " + e.toString());
      return null;
    }
    return null;
  }
}
