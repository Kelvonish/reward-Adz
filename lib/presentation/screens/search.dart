import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Form(
            child: TextFormField(
          textInputAction: TextInputAction.search,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black38,
              ),
              hintText: "Search Reward Adz",
              hintStyle: TextStyle(color: Colors.black45, fontSize: 17),
              filled: true),
        )),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.search,
              size: 50,
              color: Colors.black38,
            ),
          ),
          Center(
              child: Text(
            "Search for Advertisements",
            style: TextStyle(fontSize: 18.0, color: Colors.black45),
          )),
        ],
      ),
    );
  }
}
