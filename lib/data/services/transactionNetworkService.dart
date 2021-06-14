import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/transactionModel.dart';
import 'package:rewardadz/data/models/notificationModel.dart';
import 'package:rewardadz/data/models/userModel.dart';

class TransactionNetworkClass {
  Future<TransactionModel> getEarnings(
    UserModel user,
  ) async {
    try {
      String url = BASE_URL +
          "earnings/${user.data.id.toString()}/type/earnings/page/0/limit/50";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': user.token,
      });

      if (response.statusCode == 200) {
        var returnedData = json.decode(response.body);
        var t = TransactionModel.fromJson(returnedData);

        return t;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error : " + e.toString());
      return null;
    }
    return null;
  }

  Future<TransactionModel> getWithdrawals(UserModel user) async {
    try {
      String url = BASE_URL +
          "earnings/${user.data.id.toString()}/type/withdrawals/page/0/limit/50";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': user.token,
      });

      if (response.statusCode == 200) {
        var returnedData = json.decode(response.body);
        var t = TransactionModel.fromJson(returnedData);

        return t;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error : " + e.toString());
      return null;
    }
    return null;
  }

  Future<TransactionModel> getTransfers(UserModel user) async {
    try {
      String url = BASE_URL +
          "earnings/${user.data.id.toString()}/type/transfers/page/0/limit/50";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': user.token,
      });

      if (response.statusCode == 200) {
        var returnedData = json.decode(response.body);
        var t = TransactionModel.fromJson(returnedData);

        return t;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error : " + e.toString());
      return null;
    }
    return null;
  }

  Future<NotificationModel> getNotifications(UserModel user) async {
    try {
      String url = BASE_URL +
          "notifycenter/all/userid/${user.data.id.toString()}/page/0/limit/83";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': user.token,
      });

      if (response.statusCode == 200) {
        var returnedData = json.decode(response.body);

        var t = NotificationModel.fromJson(returnedData);

        return t;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error : " + e.toString());
      return null;
    }
    return null;
  }

  Future transfer(UserModel user, String phone, String amount) async {
    Map data = {"amount": amount, "phone": phone, "uid": user.data.id};

    try {
      String url = BASE_URL + "transfer";
      var body = json.encode(data);

      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {
            "Content-Type": "application/json",
            'x-access-token': user.token,
          },
          body: body);
      var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return returnedData;
      } else {
        if (returnedData['data'] is String) {
          Fluttertoast.showToast(msg: returnedData['data']);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Nothing " + e.toString());
      return null;
    }
    return null;
  }
}
