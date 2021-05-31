import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'package:rewardadz/data/models/transactionModel.dart';
import 'package:rewardadz/data/services/transactionNetworkService.dart';

class TransactionProvider extends ChangeNotifier {
  getEarnings(String userId) async {
    List<TransactionModel> earnings =
        await TransactionNetworkClass().getEarnings(userId);
    print(earnings);
    return earnings;
  }
}
