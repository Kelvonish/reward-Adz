import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:rewardadz/business_logic/providers/togglePasswordVisibilityProvider.dart';
import 'package:rewardadz/business_logic/Shared/validator.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/business_logic/Shared/countryCodeToName.dart';
import 'package:rewardadz/presentation/screens/login.dart';
import 'package:rewardadz/business_logic/providers/authenticationProvider.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/data/models/userModel.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextStyle _labelStyle = TextStyle(fontWeight: FontWeight.w400);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String countryIsoEmail;
  String phoneNumberEmail;
  String countryCodeEmail = "254";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    showPhoneModal(
        {BuildContext context,
        var facebook,
        GoogleSignInAccount googleAccount,
        String type}) {
      final _formKey2 = GlobalKey<FormState>();
      var _countryISoCodeSocial;
      String _phoneSocial;
      String _countryCodeSocial = "254";
      TextEditingController _socialPhoneController = TextEditingController();
      showCupertinoModalPopup(
          barrierDismissible: false,
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
                                  fontSize: 18.0, color: Colors.black),
                            ),
                          )),
                          Divider(
                            height: 5,
                          ),
                          Form(
                            key: _formKey2,
                            child: IntlPhoneField(
                              controller: _socialPhoneController,
                              initialCountryCode: "KE",
                              keyboardType: TextInputType.number,
                              autoValidate: false,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Phone Number",
                              ),
                              onChanged: (phone) {
                                setState(() {
                                  _countryISoCodeSocial = phone.countryISOCode;
                                });

                                print(phone.completeNumber);
                              },
                              onCountryChanged: (phone) {
                                setState(() {
                                  _countryCodeSocial = phone.countryCode;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(0.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey2.currentState.validate()) {
                                  String trimmedCountryCode;
                                  String trimmedNumber;

                                  if (_countryCodeSocial.contains("+", 0)) {
                                    trimmedCountryCode =
                                        _countryCodeSocial.substring(
                                            1, _countryCodeSocial.length);
                                  } else {
                                    trimmedCountryCode = _countryCodeSocial;
                                  }
                                  if (_socialPhoneController.text
                                      .contains("0", 0)) {
                                    trimmedNumber = _socialPhoneController.text
                                        .substring(1,
                                            _socialPhoneController.text.length);
                                  } else {
                                    trimmedNumber = _socialPhoneController.text;
                                  }

                                  _phoneSocial =
                                      trimmedCountryCode + trimmedNumber;
                                  if (type == "Facebook") {
                                    Navigator.pop(context);
                                    DataModel data = DataModel(
                                      email: facebook['email'],
                                      type: "Facebook",
                                      phone: _phoneSocial,
                                      country: countryCodeToName[
                                          _countryISoCodeSocial],
                                    );
                                    UserModel user = UserModel(
                                      data: data,
                                    );
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .createSocialUser(
                                            context: context,
                                            user: user,
                                            fname: facebook['first_name'],
                                            lname: facebook['last_name']);
                                  } else if (type == "Google") {
                                    String fullName = googleAccount.displayName;

                                    var res = fullName.split(" ");

                                    Navigator.pop(context);
                                    DataModel data = DataModel(
                                      email: googleAccount.email,
                                      type: "Google",
                                      phone: _phoneSocial,
                                      country: countryCodeToName[
                                          _countryISoCodeSocial],
                                    );
                                    String deviceId =
                                        await PlatformDeviceId.getDeviceId;
                                    UserModel user = UserModel(
                                      data: data,
                                    );
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .createSocialUser(
                                            context: context,
                                            user: user,
                                            fname: res[0],
                                            lname: res[1],
                                            deviceId: deviceId);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Unknown Social Type");
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text("Submit"),
                              ),
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0.0),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            0.0,
                                          ),
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor))),
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor)),
                            ),
                          )
                        ],
                      )),
                ),
              ));
    }

    return Scaffold(
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
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Card(
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Consumer<TogglePasswordProvider>(
                    builder: (context, data, child) => (Column(
                      children: [
                        IntlPhoneField(
                          controller: _phoneController,
                          dropDownArrowColor: Theme.of(context).primaryColor,
                          initialCountryCode: "KE",
                          autoValidate: false,
                          onChanged: (value) {
                            setState(() {
                              countryIsoEmail =
                                  value.countryISOCode.toUpperCase();
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Phone Number",
                              labelStyle: _labelStyle),
                          onCountryChanged: (phone) {
                            setState(() {
                              countryCodeEmail = phone.countryCode;
                            });
                          },
                        ),
                        TextFormField(
                          validator: (val) {
                            if (!validateEmail(val.trim())) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Email Address",
                              labelStyle: _labelStyle),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          validator: (val) {
                            if (!validatePassword(val)) {
                              return "Minimum is 6 characters! Should contain uppercase, lowercase and number";
                            }
                            return null;
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: data.password1,
                          decoration: InputDecoration(
                              errorMaxLines: 2,
                              //errorStyle: TextStyle(fontSize: 9),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: data.password1
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                onPressed: data.togglePassword1,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Password",
                              labelStyle: _labelStyle),
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty)
                              return 'Confirm Password field cannot be empty';
                            if (val != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          controller: _confirmPasswordController,
                          cursorColor: Theme.of(context).primaryColor,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: data.password2,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: data.password2
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                onPressed: data.togglePassword2,
                              ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Confirm Password",
                              labelStyle: _labelStyle),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: EdgeInsets.all(15.0),
                child: Consumer<UserProvider>(
                  builder: (context, value, child) => value.signUpButtonLoading
                      ? SpinKitChasingDots(
                          color: Colors.white,
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              String trimmedCountryCode;
                              String trimmedNumber;

                              if (countryCodeEmail.contains("+", 0)) {
                                trimmedCountryCode = countryCodeEmail.substring(
                                    1, countryCodeEmail.length);
                              } else {
                                trimmedCountryCode = countryCodeEmail;
                              }
                              if (_phoneController.text.contains("0", 0)) {
                                trimmedNumber = _phoneController.text
                                    .substring(1, _phoneController.text.length);
                              } else {
                                trimmedNumber = _phoneController.text;
                              }
                              phoneNumberEmail =
                                  trimmedCountryCode + trimmedNumber;
                              String deviceId =
                                  await PlatformDeviceId.getDeviceId;
                              DataModel data = DataModel(
                                  email: _emailController.text.trim(),
                                  password: _confirmPasswordController.text,
                                  phone: phoneNumberEmail,
                                  country: countryCodeToName[countryIsoEmail],
                                  type: 'Email');
                              UserModel user = UserModel(
                                data: data,
                              );
                              value.createUser(context, user, deviceId);
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                          ),
                          child: value.signUpButtonLoading
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )
                              : Text(
                                  "SIGN UP ",
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
                height: 10.0,
              ),
              Consumer<AuthenticationProvider>(
                builder: (context, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        var profile = await value.facebookSignUp(context);

                        if (profile != null) {
                          showPhoneModal(
                              context: context,
                              facebook: profile,
                              type: "Facebook");
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
                        if (profile != null) {
                          showPhoneModal(
                              context: context,
                              googleAccount: profile,
                              type: "Google");
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
                                backgroundImage: AssetImage("assets/apple.png"),
                              ),
                            ),
                          )
                        : InkWell(
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
                                    AssetImage("assets/twitter.png"),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  "Already have an account?",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Terms and Conditions",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
