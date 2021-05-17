import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rewardadz/business_logic/providers/togglePasswordVisibilityProvider.dart';
import 'package:rewardadz/presentation/screens/account%20Creation/createAccount.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/presentation/screens/navigator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle _labelStyle = TextStyle(fontWeight: FontWeight.w400);

  final _formKey = GlobalKey<FormState>();
  var _scaffoldState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
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
                        TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Email Address",
                              labelStyle: _labelStyle),
                        ),
                        Consumer<TogglePasswordProvider>(
                          builder: (context, data, child) => TextField(
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: data.password3,
                            decoration: InputDecoration(
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigator()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                    child: Text(
                      "Login ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/facebook.png"),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Container(
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
                    SizedBox(
                      width: 8.0,
                    ),
                    Container(
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
                  ],
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
                                                fontSize: 18.0,
                                                color: Colors.black),
                                          ),
                                        )),
                                        Divider(
                                          height: 5,
                                        ),
                                        IntlPhoneField(
                                          initialCountryCode: "KE",
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              labelText: "Phone Number",
                                              labelStyle: _labelStyle),
                                          onChanged: (phone) {
                                            print(phone.completeNumber);
                                          },
                                          onCountryChanged: (phone) {
                                            print('Country code changed to: ' +
                                                phone.countryCode);
                                          },
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.all(0.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
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
