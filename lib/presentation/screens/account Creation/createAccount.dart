import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rewardadz/business_logic/providers/togglePasswordVisibilityProvider.dart';
import 'package:rewardadz/business_logic/Shared/validator.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/business_logic/Shared/countryCodeToName.dart';
import 'package:rewardadz/presentation/screens/login.dart';
import 'package:rewardadz/business_logic/authentication/createAccount.dart';
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
  String country;
  String countryCode;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    showPhoneModal(BuildContext context, var profile) {
      final _formKey2 = GlobalKey<FormState>();
      var _countryCode;
      String _phone;
      TextEditingController _phoneController = TextEditingController();
      showCupertinoModalPopup(
          barrierDismissible: false,
          context: context,
          builder: (context) => Container(
                margin: EdgeInsets.all(15.0),
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                      height: 186,
                      margin: MediaQuery.of(context).viewInsets,
                      color: Colors.white,
                      child: Column(
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
                              validator: (value) => value.length <= 8
                                  ? "Enter a valid number"
                                  : null,
                              controller: _phoneController,
                              initialCountryCode: "KE",
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Phone Number",
                                //labelStyle: _labelStyle
                              ),
                              onChanged: (phone) {
                                setState(() {
                                  _countryCode = phone.countryISOCode;
                                  _phone = phone.completeNumber;
                                });

                                print(phone.completeNumber);
                              },
                              onCountryChanged: (phone) {
                                print('Country code changed to: ' +
                                    phone.countryCode);
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(0.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey2.currentState.validate()) {
                                  Navigator.pop(context);
                                  DataModel data = DataModel(
                                    email: profile['email'],
                                    type: "Facebook",
                                    phone: _phone,
                                    country: countryCodeToName[_countryCode],
                                  );
                                  UserModel user = UserModel(
                                    data: data,
                                  );
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .createSocialUser(context, user);
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
      body: SingleChildScrollView(
        child: Container(
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
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(9)
                          ],
                          initialCountryCode: "KE",
                          autoValidate: false,
                          validator: (value) {
                            if (value.length != 9) {
                              return "Please enter a valid number";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              country = value.countryISOCode.toUpperCase();
                              countryCode = value.countryCode;
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
                              country = phone.countryISOCode.toUpperCase();
                              countryCode = phone.countryCode;
                            });
                            print('Country code changed to: ' +
                                phone.countryCode);
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
                              return "Minimum is 6 characters! Should contain uppercase,lowecase,character and number";
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              DataModel data = DataModel(
                                  email: _emailController.text.trim(),
                                  password: _confirmPasswordController.text,
                                  phone: countryCode + _phoneController.text,
                                  country: countryCodeToName[country],
                                  type: 'Email');
                              UserModel user = UserModel(
                                data: data,
                              );
                              value.createUser(context, user);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      var profile = await facebookSignUp(context);
                      if (profile != null) {
                        showPhoneModal(context, profile);
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
                    onTap: googleLogin,
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
                  InkWell(
                    onTap: twitterLogin,
                    child: Container(
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
                  ),
                ],
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
