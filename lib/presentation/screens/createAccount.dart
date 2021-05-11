import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rewardadz/business_logic/providers/togglePasswordVisibilityProvider.dart';
import 'package:rewardadz/business_logic/Shared/validator.dart';
import 'package:rewardadz/presentation/screens/login.dart';
import 'package:rewardadz/business_logic/authentication/createAccount.dart';
import 'package:rewardadz/presentation/screens/navigator.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextStyle _labelStyle = TextStyle(fontWeight: FontWeight.w400);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.25,
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
                          initialCountryCode: "KE",
                          validator: (value) {
                            if (value.length != 9) {
                              return "Please enter a valid number";
                            }
                            return null;
                          },
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
                        TextFormField(
                          validator: (val) {
                            if (!validateEmail(val)) {
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
                            if (val.length < 6) {
                              return "Minimum is 6 characters";
                            }
                            if (!validatePassword(val)) {
                              return "Should contain uppercase,lowecase,character and number";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: data.password1,
                          decoration: InputDecoration(
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
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigator()));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  child: Text(
                    "SIGN UP ",
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
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: facebookLogin,
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
