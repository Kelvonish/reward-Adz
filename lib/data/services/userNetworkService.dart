import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/userModel.dart';

class UserNetworkService {
  Future<UserModel> createUser(UserModel user, String deviceId) async {
    Map data = {
      'email': user.data.email,
      "password": user.data.password,
      "phone": user.data.phone,
      "country": user.data.country,
      "type": user.data.type,
      "deviceid": deviceId,
      "versioncode": 10
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

  Future<UserModel> createSocialUser(UserModel user, String deviceId) async {
    Map data = {
      'email': user.data.email,
      "type": user.data.type,
      "phone": user.data.phone,
      "country": user.data.country,
      "versioncode": 10,
      "deviceid": deviceId
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

  Future<UserModel> loginUser(UserModel user, String deviceId) async {
    Map data = {
      'email': user.data.email,
      "password": user.data.password,
      "versioncode": 10,
      "deviceid": deviceId,
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

  Future<UserModel> loginSocialUser(UserModel user, String deviceId) async {
    Map data = {
      'email': user.data.email,
      'type': user.data.type,
      'deviceid': deviceId,
      'versioncode': 10
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

  Future<UserModel> updateUserDetails(UserModel user) async {
    Map data = {
      "dob": user.data.dob,
      "fname": user.data.fname,
      "gender": user.data.gender,
      "lname": user.data.lname,
      "email": user.data.email,
      "phone": user.data.phone
    };

    try {
      String url = BASE_URL + "users/" + user.data.id.toString();
      var body = json.encode(data);
      print(body);
      var parsedUrl = Uri.parse(url);

      var response = await http.put(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Successfully updated details");
        return UserModel.fromJson(returnedData);
      } else {
        Fluttertoast.showToast(msg: "Error updating details");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Nothing " + e.toString());
      return null;
    }
    return null;
  }

  Future<bool> sendOtp(UserModel user) async {
    Map data = {
      "id": user.data.id,
    };

    try {
      String url = BASE_URL + "resendotp";
      var body = json.encode(data);
      print(body);
      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      //var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "OTP sent");
        return true;
      } else {
        Fluttertoast.showToast(msg: "Error sending Otp");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error : " + e.toString());
      return false;
    }
  }

  Future<bool> forgotPassword(String phoneNumber) async {
    Map data = {
      "phone": phoneNumber,
    };

    try {
      String url = BASE_URL + "reset";
      var body = json.encode(data);
      print(body);
      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      //var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "A new password has been sent to your email");
        return true;
      } else {
        Fluttertoast.showToast(msg: "User not found");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error : " + e.toString());
      return false;
    }
  }

  Future<bool> verifyOtp(UserModel user, String otpCode) async {
    Map data = {
      "code": otpCode,
      "id": user.data.id,
    };

    try {
      String url = BASE_URL + "confirm";
      var body = json.encode(data);

      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (returnedData['status'] == "true") {
          Fluttertoast.showToast(msg: "Successfully verified ");
          return true;
        } else {
          Fluttertoast.showToast(msg: "OTP not correct");
          return false;
        }
      } else {
        Fluttertoast.showToast(msg: "Error");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error : " + e.toString());
      return false;
    }
  }

  Future<UserModel> getUser(UserModel user) async {
    try {
      String url = BASE_URL + "users/${user.data.id}";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl, headers: {
        "Content-Type": "application/json",
        'x-access-token': user.token,
      });
      var returnedData = json.decode(response.body);

      if (response.statusCode == 200) {
        return UserModel.fromJson(returnedData);
      } else {
        if (returnedData['data'] is String) {
          Fluttertoast.showToast(msg: returnedData['data']);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error getting user: " + e.toString());
      return null;
    }
    return null;
  }

  Future<UserModel> resetPassword(int userId, String newPassword) async {
    Map data = {'uid': userId, 'newpassword': newPassword};

    try {
      String url = BASE_URL + "reset/inmobile";
      var body = json.encode(data);
      print(body);
      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return UserModel.fromJson(returnedData);
      } else {
        Fluttertoast.showToast(msg: "error 500. Reseting password");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Nothing " + e.toString());
      return null;
    }
    return null;
  }

  Future<bool> uploadProfileImage(String filename, UserModel user) async {
    String url = BASE_URL + "users/image";

    //create multipart request for POST or PATCH method
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      //add text fields
      request.fields["id"] = user.data.id.toString();
      //create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath("image", filename);

      request.files.add(pic);
      var response = await request.send();

      var responseData = await response.stream.toBytes();

      var responseString = String.fromCharCodes(responseData);
      print(responseString);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Image upload successful");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
