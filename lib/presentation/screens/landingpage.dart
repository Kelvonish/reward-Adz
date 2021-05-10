import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rewardadz/presentation/screens/createAccount.dart';
import 'package:rewardadz/presentation/screens/login.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
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
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 100,
                    margin: EdgeInsets.only(top: 150),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/adventure.png"),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      //margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Image.asset(
                        "assets/picture.png",
                        scale: 1.0,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Text(
                    "Let the Reward Ad-venture begin",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Watch, Listen, Share to earn rewards",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        margin: EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccount()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: Text(
                            "Create Account ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        margin: EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                          ),
                          child: Text(
                            "Login ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
