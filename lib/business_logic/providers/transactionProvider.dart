import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'package:rewardadz/data/models/transactionModel.dart';
import 'package:rewardadz/data/services/transactionNetworkService.dart';

class TransactionProvider extends ChangeNotifier {
  getEarnings(String userId) async {
    TransactionModel earnings =
        await TransactionNetworkClass().getEarnings(userId);

    return earnings;
  }

  getWithdrawals(String userId) async {
    TransactionModel withdrawals =
        await TransactionNetworkClass().getWithdrawals(userId);
    print("here withdrawals");

    return withdrawals;
  }

  getTransfers(String userId) async {
    TransactionModel transfers =
        await TransactionNetworkClass().getTransfers(userId);

    return transfers;
  }
}
