import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/transactionModel.dart';
import 'package:rewardadz/data/models/notificationModel.dart';
import 'package:rewardadz/presentation/screens/notifications.dart';

class TransactionNetworkClass {
  Future<TransactionModel> getEarnings(String userId) async {
    try {
      String url = BASE_URL + "earnings/$userId/type/earnings/page/0/limit/50";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl);

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

  Future<TransactionModel> getWithdrawals(String userId) async {
    try {
      String url =
          BASE_URL + "earnings/$userId/type/withdrawals/page/0/limit/50";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl);

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

  Future<TransactionModel> getTransfers(String userId) async {
    try {
      String url = BASE_URL + "earnings/$userId/type/transfers/page/0/limit/50";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl);

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

  Future<NotificationModel> getNotifications(String userId) async {
    try {
      String url = BASE_URL + "notifycenter/all/userid/$userId/page/0/limit/83";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl);

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

  Future transfer(int userId, String phone, String amount) async {
    Map data = {"amount": amount, "phone": phone, "uid": userId};

    try {
      String url = BASE_URL + "transfer";
      var body = json.encode(data);

      var parsedUrl = Uri.parse(url);

      var response = await http.post(parsedUrl,
          headers: {"Content-Type": "application/json"}, body: body);
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
