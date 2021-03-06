import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/local%20storage/userPreference.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/main.dart';

class VerifyOtp extends StatefulWidget {
  final UserModel user;
  VerifyOtp({this.user});
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  int _start = 60;
  int _current = 60;
  final _formKey = GlobalKey<FormState>();
  String enteredOtp;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

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
                Theme.of(context).highlightColor,
                Theme.of(context).accentColor
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  "Verification Code",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Please enter the verification code sent to " +
                      widget.user.data.phone,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 70.0,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,
                        obscureText: false,

                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length < 4) {
                            return "Please enter 4 digits";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          inactiveColor: Colors.white,
                          selectedColor: Colors.white,
                          activeColor: Colors.white,
                          disabledColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Theme.of(context).primaryColor,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        //errorAnimationController: errorController,
                        //controller: textEditingController,
                        keyboardType: TextInputType.number,

                        onChanged: (value) {
                          setState(() {
                            enteredOtp = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Consumer<UserProvider>(
                  builder: (context, value, child) => value.loginButtonLoading
                      ? Center(
                          child: SpinKitChasingDots(
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor)),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  value.verifyOtp(
                                      context, widget.user, enteredOtp);
                                }

                                /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigator()));*/
                              },
                              child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("Verify")))),
                ),
                SizedBox(
                  height: 50.0,
                ),
                _current != 0
                    ? Text(
                        "Resend in $_current seconds",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0),
                        textAlign: TextAlign.center,
                      )
                    : Consumer<UserProvider>(
                        builder: (context, value, child) => InkWell(
                          onTap: () {
                            setState(() {
                              value.resendOtp(value.loggedUser);
                              _current = 60;
                            });
                            _startTimer();
                          },
                          child: Text(
                            "Resend verification code",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 16.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    UserPreferences userPref = UserPreferences();
                    bool done = await userPref.removeUser();
                    /*
                    await Provider.of<AuthenticationProvider>(context,
                            listen: false)
                        .logoutSocial();*/
                    if (done) {
                      Provider.of<UserProvider>(context, listen: false)
                          .loggedUser = null;

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MyApp()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
