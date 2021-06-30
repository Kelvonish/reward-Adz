import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:rewardadz/business_logic/Shared/validator.dart';
import 'package:rewardadz/business_logic/providers/authenticationProvider.dart';
import 'package:rewardadz/business_logic/providers/togglePasswordVisibilityProvider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/presentation/screens/account%20Creation/createAccount.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle _labelStyle = TextStyle(fontWeight: FontWeight.w400);

  final _formKey = GlobalKey<FormState>();
  var _scaffoldState;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String resetPhone;
  String resetCountryCode = "254";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                const Color.fromRGBO(114, 145, 219, 1),
                Theme.of(context).accentColor
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Card(
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (val) {
                            if (!validateEmail(val.trim())) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Email Address",
                              labelStyle: _labelStyle),
                        ),
                        Consumer<TogglePasswordProvider>(
                          builder: (context, data, child) => TextFormField(
                            controller: _passwordController,
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (val) =>
                                val.isEmpty ? "Please Enter password" : null,
                            obscureText: data.password3,
                            decoration: InputDecoration(
                                errorMaxLines: 2,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: data.password3
                                      ? Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                  onPressed: data.togglePassword3,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Password",
                                labelStyle: _labelStyle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<UserProvider>(
                  builder: (context, value, child) => value.loginButtonLoading
                      ? Center(
                          child: SpinKitChasingDots(color: Colors.white),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: EdgeInsets.all(15.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                String deviceId =
                                    await PlatformDeviceId.getDeviceId;
                                DataModel data = DataModel(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                    type: 'Email');
                                UserModel user = UserModel(
                                  data: data,
                                );

                                value.loginUser(context, user, deviceId);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                            ),
                            child: Text(
                              "Login ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "-- or --",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Consumer<AuthenticationProvider>(
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          String deviceId = await PlatformDeviceId.getDeviceId;
                          var profile = await value.facebookSignUp(context);
                          print(profile);
                          if (profile != null) {
                            DataModel data = DataModel(
                              email: profile['email'],
                              type: "Facebook",
                            );
                            UserModel user = UserModel(
                              data: data,
                            );
                            Provider.of<UserProvider>(context, listen: false)
                                .loginSocialUser(
                                    context: context,
                                    user: user,
                                    deviceId: deviceId);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/facebook.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      InkWell(
                        onTap: () async {
                          var profile = await value.googleLogin();
                          String deviceId = await PlatformDeviceId.getDeviceId;
                          if (profile != null) {
                            DataModel data = DataModel(
                              email: profile.email,
                              type: "Google",
                            );
                            UserModel user = UserModel(
                              data: data,
                            );
                            Provider.of<UserProvider>(context, listen: false)
                                .loginSocialUser(
                                    context: context,
                                    user: user,
                                    deviceId: deviceId);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("assets/google.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Platform.isIOS
                          ? InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage("assets/apple.png"),
                                ),
                              ),
                            )
                          : Text(""),
                      /*Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/twitter.png"),
                        ),
                      ),
                      */
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                              margin: EdgeInsets.all(15.0),
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                    margin: MediaQuery.of(context).viewInsets,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Phone Number",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black),
                                          ),
                                        )),
                                        Divider(
                                          height: 5,
                                        ),
                                        IntlPhoneField(
                                          initialCountryCode: "KE",
                                          controller: _phoneController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: "Phone Number",
                                              labelStyle: _labelStyle),
                                          onCountryChanged: (phone) {
                                            resetCountryCode =
                                                phone.countryCode;
                                          },
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.all(0.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              String trimmedCountryCode;
                                              String trimmedNumber;
                                              if (_phoneController.text !=
                                                      null &&
                                                  _phoneController.text.length >
                                                      5) {
                                                Navigator.pop(context);
                                                if (resetCountryCode.contains(
                                                    "+", 0)) {
                                                  trimmedCountryCode =
                                                      resetCountryCode
                                                          .substring(
                                                              1,
                                                              resetCountryCode
                                                                  .length);
                                                } else {
                                                  trimmedCountryCode =
                                                      resetCountryCode;
                                                }
                                                if (_phoneController.text
                                                    .contains("0", 0)) {
                                                  trimmedNumber =
                                                      _phoneController.text
                                                          .substring(
                                                              1,
                                                              _phoneController
                                                                  .text.length);
                                                } else {
                                                  trimmedNumber =
                                                      _phoneController.text;
                                                }
                                                resetPhone =
                                                    trimmedCountryCode +
                                                        trimmedNumber;

                                                Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .forgotPassword(resetPhone);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please enter a valid phone number");
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text("Submit"),
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
                                    )),
                              ),
                            ));
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
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
                            builder: (context) => CreateAccount()));
                  },
                  child: Text(
                    "Sign up for Reward Adz",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
