import 'package:flutter/material.dart';

class OngoingCampaigns extends StatefulWidget {
  @override
  _OngoingCampaignsState createState() => _OngoingCampaignsState();
}

class _OngoingCampaignsState extends State<OngoingCampaigns> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/ongoing.png"),
        Text(
          "Ongoing Ringtone campaigns are shown here",
          style: TextStyle(fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
