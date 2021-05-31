import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/transactionModel.dart';

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
}
