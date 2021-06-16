import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/providers/checkInternetProvider.dart';

import 'package:rewardadz/data/models/transactionModel.dart';
import 'package:rewardadz/data/models/notificationModel.dart';
import 'package:rewardadz/data/models/userModel.dart';
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
  bool withdrawModalLoading = false;
  bool transferModalLoading = false;
  checkInternetConnection() async {
    isInternetConnected = await ConnectivityService().checkInternetConnection();
    notifyListeners();
  }

  getEarnings(UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      earningsLoading = true;
      notifyListeners();
      allEarnings = await TransactionNetworkClass().getEarnings(user);
    }
    earningsLoading = false;
    notifyListeners();
  }

  getWithdrawals(UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      withdrawsLoading = true;
      notifyListeners();
      allWithdrawals = await TransactionNetworkClass().getWithdrawals(user);
    }
    withdrawsLoading = false;
    notifyListeners();
  }

  getTransfers(UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      transfersLoading = true;
      notifyListeners();
      allTransfers = await TransactionNetworkClass().getTransfers(user);
    }
    transfersLoading = false;
    notifyListeners();
  }

  getNotifications(UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      notificationsLoading = true;
      notifyListeners();
      notifications = await TransactionNetworkClass().getNotifications(user);
    }
    notificationsLoading = false;
    notifyListeners();
  }

  transfer(UserModel user, String amount, String phone) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      transferModalLoading = true;
      notifyListeners();
      notifications =
          await TransactionNetworkClass().transfer(user, phone, amount);
    }
    transferModalLoading = false;
    notifyListeners();
  }

  withdraw(UserModel user, int amount) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      withdrawModalLoading = true;
      notifyListeners();
      bool success = await TransactionNetworkClass().withdraw(user, amount);
      if (success) {}
    }
    withdrawModalLoading = false;
    notifyListeners();
  }
}
