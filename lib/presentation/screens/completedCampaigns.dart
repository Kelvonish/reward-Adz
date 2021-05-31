import 'package:flutter/material.dart';

class CompletedCampaigns extends StatefulWidget {
  @override
  _CompletedCampaignsState createState() => _CompletedCampaignsState();
}

class _CompletedCampaignsState extends State<CompletedCampaigns> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/completed.png"),
        Text(
          "All the completed campaigns will be shown here",
          style: TextStyle(fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
