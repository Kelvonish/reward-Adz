import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/Shared/validator.dart';
import 'package:rewardadz/business_logic/providers/togglePasswordVisibilityProvider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/local%20storage/userPreference.dart';
import 'package:rewardadz/main.dart';
import 'package:rewardadz/presentation/screens/notifications.dart';
import 'package:rewardadz/presentation/widgets/balanceCardTile.dart';
import 'package:rewardadz/presentation/screens/editprofile.dart';
import 'package:rewardadz/presentation/screens/privacyPolicyWebView.dart';
import 'package:rewardadz/presentation/screens/termsOfService.dart';
import 'package:rewardadz/presentation/widgets/profileImage.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextStyle _titleStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
  TextStyle _labelStyle = TextStyle(fontSize: 14.0);
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Consumer<UserProvider>(
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProfileImage(
                    url: value.loggedUser.data.image,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    value.loggedUser.data.fname +
                        " " +
                        value.loggedUser.data.lname,
                    style: _titleStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Consumer<UserProvider>(
              builder: (context, value, child) => BalanceCard(
                name: "Total Earnings",
                currency: value.loggedUser.data.currency,
                earnedAmount: value.loggedUser.totalreward.toString(),
                numberOfAds: value.loggedUser.earnedads.toString(),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.person_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Edit Profile",
                        style: _labelStyle,
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black45,
                    size: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notifications()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.notifications_none,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Notifications",
                        style: _labelStyle,
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black45,
                    size: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return Container(
                        margin: EdgeInsets.all(15.0),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                              margin: MediaQuery.of(context).viewInsets,
                              color: Colors.white,
                              child: Consumer<UserProvider>(
                                builder: (context, user, child) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0, bottom: 8.0),
                                        child: Icon(
                                          Icons.lock,
                                          size: 50,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Reset Password",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                    Consumer<TogglePasswordProvider>(
                                      builder: (context, data, child) => Form(
                                          child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              cursorColor: Theme.of(context)
                                                  .primaryColor,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: data.password4,
                                              controller: _passwordController,
                                              validator: (val) {
                                                if (!validatePassword(val)) {
                                                  return "Minimum is 6 characters! Should contain uppercase,lowercase and number";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  errorMaxLines: 2,
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  suffixIcon: IconButton(
                                                    icon: data.password4
                                                        ? Icon(
                                                            Icons.visibility,
                                                            color: Colors.grey,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .visibility_off,
                                                            color: Colors.grey,
                                                          ),
                                                    onPressed:
                                                        data.togglePassword4,
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  labelText: "Password",
                                                  labelStyle: _labelStyle),
                                            ),
                                            Divider(
                                              height: 8,
                                            ),
                                            TextFormField(
                                              cursorColor: Theme.of(context)
                                                  .primaryColor,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: data.password5,
                                              controller:
                                                  _confirmPasswordController,
                                              validator: (val) {
                                                if (val.isEmpty)
                                                  return 'Confirm Password field cannot be empty';
                                                if (val !=
                                                    _passwordController.text) {
                                                  return 'Passwords do not match';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  suffixIcon: IconButton(
                                                    icon: data.password5
                                                        ? Icon(
                                                            Icons.visibility,
                                                            color: Colors.grey,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .visibility_off,
                                                            color: Colors.grey,
                                                          ),
                                                    onPressed:
                                                        data.togglePassword5,
                                                  ),
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  labelText: "Confirm Password",
                                                  labelStyle: _labelStyle),
                                            )
                                          ],
                                        ),
                                      )),
                                    ),
                                    user.resetButtonLoading
                                        ? Center(
                                            child: SpinKitChasingDots(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.all(15.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  if (user.loggedUser.data
                                                          .type ==
                                                      "Email") {
                                                    user.resetPassword(
                                                        context: context,
                                                        userId: user
                                                            .loggedUser.data.id,
                                                        newPassword:
                                                            _confirmPasswordController
                                                                .text);
                                                  } else {
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg: "You are logged in using " +
                                                            user.loggedUser.data
                                                                .type +
                                                            " password is not needed");
                                                  }
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text("Reset"),
                                              ),
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0.0),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            0.0,
                                                          ),
                                                          side: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Theme.of(context)
                                                              .primaryColor)),
                                            ),
                                          )
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.lock_outline_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Reset Password",
                        style: _labelStyle,
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black45,
                    size: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacyPolicyWebView()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.vpn_key_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Privacy Policy",
                        style: _labelStyle,
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black45,
                    size: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsOfServiceWebView()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.wallet_travel_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Terms of service",
                        style: _labelStyle,
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black45,
                    size: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () async {
                            UserPreferences userPref = UserPreferences();
                            bool done = await userPref.removeUser();
                            /* await Provider.of<AuthenticationProvider>(context,
                                    listen: false)
                                .logoutSocial();*/
                            if (done) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .loggedUser = null;

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                  (Route<dynamic> route) => false);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.logout,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Logout",
                        style: _labelStyle,
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black45,
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
