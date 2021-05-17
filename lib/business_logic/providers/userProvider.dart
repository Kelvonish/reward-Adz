import 'package:flutter/cupertino.dart';
import 'package:rewardadz/data/services/userNetworkService.dart';

class UserProvider extends ChangeNotifier {
  UserNetworkService userClass = UserNetworkService();
  bool signUpButtonLoading = true;

  createUser(
      String email, String phonenumber, String country, String password) async {
    signUpButtonLoading = true;
    await userClass.createUser(email, phonenumber, country, password);
    signUpButtonLoading = false;
    notifyListeners();
  }
}
