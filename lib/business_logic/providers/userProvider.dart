import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/providers/checkInternetProvider.dart';
import 'package:rewardadz/data/services/userNetworkService.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/main.dart';
import 'package:rewardadz/presentation/screens/account%20Creation/addAccountDetails.dart';
import 'package:rewardadz/presentation/screens/account%20Creation/verifyOtp.dart';
import 'package:rewardadz/data/local storage/userPreference.dart';
import 'package:rewardadz/presentation/screens/navigator.dart';

class UserProvider extends ChangeNotifier {
  UserPreferences userPref = UserPreferences();
  UserNetworkService userClass = UserNetworkService();
  bool signUpButtonLoading = false;
  bool loginButtonLoading = false;
  bool accountDetailButton = false;
  UserModel loggedUser;

  bool isInternetConnected;
  checkInternetConnection() async {
    isInternetConnected = await ConnectivityService().checkInternetConnection();
    notifyListeners();
  }

  getLoggedInUser() async {
    loggedUser = await UserPreferences().getUser();
    notifyListeners();
    return loggedUser;
  }

  createUser(BuildContext context, UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      signUpButtonLoading = true;
      notifyListeners();
      UserModel result = await userClass.createUser(user);

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
  }

  createSocialUser(
      {BuildContext context,
      UserModel user,
      String fname,
      String lname}) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
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
  }

  updateUserDetails(BuildContext context, UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      accountDetailButton = true;
      notifyListeners();
      UserModel result = await userClass.addUserDetails(user);
      if (result != null) {
        userPref.saveUser(result);

        var _sentOtp = await userClass.sendOtp(result);
        if (_sentOtp) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtp(
                        user: result,
                      )));
        }
      }
      accountDetailButton = false;
      notifyListeners();
    }
  }

  loginUser(BuildContext context, UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loginButtonLoading = true;
      notifyListeners();
      UserModel result = await userClass.loginUser(user);

      if (result != null) {
        userPref.saveUser(result);
        loginButtonLoading = false;
        notifyListeners();
        Fluttertoast.showToast(
            msg: "Successfully logged in!",
            backgroundColor: Theme.of(context).primaryColor);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => MyApp()));
      }
      loginButtonLoading = false;
      notifyListeners();
    }
  }

  loginSocialUser({
    BuildContext context,
    UserModel user,
  }) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loginButtonLoading = true;
      notifyListeners();

      UserModel result = await userClass.loginSocialUser(user);

      if (result != null) {
        userPref.saveUser(result);
        loginButtonLoading = false;
        notifyListeners();
        Fluttertoast.showToast(
            msg: "Successfully logged in!",
            backgroundColor: Theme.of(context).primaryColor);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => MyApp()));
      }
      loginButtonLoading = false;
      notifyListeners();
    }
  }

  updateProfile(BuildContext context, UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loginButtonLoading = true;
      notifyListeners();

      UserModel result = await userClass.updateUserDetails(user);

      if (result != null) {
        var existingUser = await UserPreferences().getUser();
        existingUser.data = result.data;

        userPref.saveUser(existingUser);
        getLoggedInUser();
        loginButtonLoading = false;
        notifyListeners();
      }
      loginButtonLoading = false;
      notifyListeners();
    }
  }

  verifyOtp(BuildContext context, UserModel user, String otpCode) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loginButtonLoading = true;
      notifyListeners();

      bool verified = await userClass.verifyOtp(user, otpCode);

      if (verified) {
        loginButtonLoading = false;
        notifyListeners();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      }
      loginButtonLoading = false;
      notifyListeners();
    }
  }

  resendOtp(UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      await userClass.sendOtp(user);
    }
  }
}
