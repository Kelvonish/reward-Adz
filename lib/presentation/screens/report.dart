import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/getCampaignProvider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/presentation/screens/startedCampaigns.dart';
import 'package:rewardadz/presentation/screens/completedCampaigns.dart';
import 'package:rewardadz/presentation/screens/ongoingCampaigns.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetCampaignProvider>(context, listen: false)
        .getCompletedCampaigns(
            Provider.of<UserProvider>(context, listen: false).loggedUser);
  }

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
            CompletedCampaigns(),
            StartedCampaigns(),
            OngoingCampaigns(),
          ],
        ),
      ),
    );
  }
}
