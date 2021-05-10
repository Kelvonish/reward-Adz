import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black38,
            onTap: (index) {
              // Tab index when user select it, it start from zero
            },
            tabs: [
              Tab(text: "Completed"),
              Tab(text: "Started"),
              Tab(text: "Ongoing"),
            ],
          ),
          title: Text(
            'My Report',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
                child: Text(
              "0",
              style: TextStyle(fontSize: 40),
            )),
            Center(
                child: Text(
              "1",
              style: TextStyle(fontSize: 40),
            )),
            Center(
                child: Text(
              "2",
              style: TextStyle(fontSize: 40),
            )),
          ],
        ),
      ),
    );
  }
}
