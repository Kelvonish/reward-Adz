import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/transactionModel.dart';

class TransactionNetworkClass {
  Future<List<TransactionModel>> getEarnings(String userId) async {
    List<TransactionModel> earnings = [];

    try {
      String url = BASE_URL + "earnings/$userId/type/earnings/page/0/limit/50";

      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl);

      if (response.statusCode == 200) {
        var returnedData = json.decode(response.body);
        returnedData['data'].forEach((element) {
          TransactionModel newData = TransactionModel.fromJson(element);

          earnings.add(newData);
        });
        print(earnings);

        return earnings;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error : " + e.toString());
      return null;
    }
    return null;
  }
}
