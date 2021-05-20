import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Widget checkSession() {
    UserModel userSaved;
    Widget screen;
    UserPreferences().getUser().then((result) => {
          userSaved = result,
          print("User is : "),
          print(userSaved.data.id),
          if (userSaved.data.id != null)
            {
              if (userSaved.data.dob == null ||
                  userSaved.data.lname == null ||
                  userSaved.data.fname == null ||
                  userSaved.data.gender == null)
                {
                  screen = AddAccountDetails(
                    user: userSaved,
                  ),
                }
              else
                {
                  screen = LandingPage(),
                }
            }
          else
            {
              screen = BottomNavigator(),
            }
        });

    return screen;
  }
}
