import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/providers/checkInternetProvider.dart';

import 'package:rewardadz/data/models/transactionModel.dart';
import 'package:rewardadz/data/models/notificationModel.dart';
import 'package:rewardadz/data/services/transactionNetworkService.dart';

class TransactionProvider extends ChangeNotifier {
  bool isInternetConnected;
  TransactionModel allEarnings;
  TransactionModel allWithdrawals;
  TransactionModel allTransfers;
  NotificationModel notifications;
  bool earningsLoading = false;
  bool withdrawsLoading = false;
  bool transfersLoading = false;
  bool notificationsLoading = false;
  checkInternetConnection() async {
    isInternetConnected = await ConnectivityService().checkInternetConnection();
    notifyListeners();
  }

  getEarnings(String userId) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      earningsLoading = true;
      notifyListeners();
      allEarnings = await TransactionNetworkClass().getEarnings(userId);
    }
    earningsLoading = false;
    notifyListeners();
  }

  getWithdrawals(String userId) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      withdrawsLoading = true;
      notifyListeners();
      allWithdrawals = await TransactionNetworkClass().getWithdrawals(userId);
    }
    withdrawsLoading = false;
    notifyListeners();
  }

  getTransfers(String userId) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      transfersLoading = true;
      notifyListeners();
      allTransfers = await TransactionNetworkClass().getTransfers(userId);
    }
    transfersLoading = false;
    notifyListeners();
  }

  getNotifications(String userId) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      notificationsLoading = true;
      notifyListeners();
      notifications = await TransactionNetworkClass().getNotifications(userId);
    }
    notificationsLoading = false;
    notifyListeners();
  }
}
