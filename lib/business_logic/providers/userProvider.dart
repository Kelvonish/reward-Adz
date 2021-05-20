import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/data/services/userNetworkService.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/presentation/screens/account%20Creation/addAccountDetails.dart';
import 'package:rewardadz/presentation/screens/account%20Creation/verifyOtp.dart';
import 'package:rewardadz/data/local storage/userPreference.dart';
import 'package:rewardadz/presentation/screens/landingpage.dart';
import 'package:rewardadz/presentation/screens/navigator.dart';

enum Status { NotLoggedIn, LoggedIn, LoggedOut }

class UserProvider extends ChangeNotifier {
  UserPreferences userPref = UserPreferences();
  UserNetworkService userClass = UserNetworkService();
  bool signUpButtonLoading = false;
  bool loginButtonLoading = false;
  bool accountDetailButton = false;
  Status _loggedInStatus = Status.NotLoggedIn;
  Status get loggedInStatus => _loggedInStatus;

  createUser(BuildContext context, UserModel user) async {
    signUpButtonLoading = true;
    notifyListeners();
    UserModel result = await userClass.createUser(user);

    if (result != null) {
      _loggedInStatus = Status.LoggedIn;
      print(userPref.saveUser(result));
      userPref.getUser();
      notifyListeners();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddAccountDetails(
                    user: result,
                  )));
    }
    signUpButtonLoading = false;
    notifyListeners();
  }

  createSocialUser(BuildContext context, UserModel user) async {
    signUpButtonLoading = true;
    notifyListeners();
    UserModel result = await userClass.createSocialUser(user);

    if (result != null) {
      userPref.getUser();
      notifyListeners();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddAccountDetails(
                    user: result,
                  )));
    }
    signUpButtonLoading = false;
    notifyListeners();
  }

  updateUserDetails(BuildContext context, UserModel user) async {
    accountDetailButton = true;
    notifyListeners();
    UserModel result = await userClass.addUserDetails(user);
    if (result != null) {
      print(userPref.saveUser(result));
      var loggedInUser = userPref.getUser();
      print(loggedInUser);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VerifyOtp()));
    }
    accountDetailButton = false;
    notifyListeners();
  }

  loginUser(BuildContext context, UserModel user) async {
    loginButtonLoading = true;
    notifyListeners();
    UserModel result = await userClass.loginUser(user);

    if (result != null) {
      userPref.saveUser(result);

      Fluttertoast.showToast(
          msg: "Successfully logged in!",
          backgroundColor: Theme.of(context).primaryColor);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavigator()));
    }
    loginButtonLoading = false;
    notifyListeners();
  }
}
