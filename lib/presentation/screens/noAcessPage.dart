import 'package:flutter/material.dart';

class NoAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
          child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/error.png"),
              Text(
                "You cannot access our app with a rooted device for security purposes",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      )),
    );
  }
}
