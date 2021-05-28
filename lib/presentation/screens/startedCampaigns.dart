import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/database/campaignDatabase.dart';

class StartedCampaigns extends StatefulWidget {
  @override
  _StartedCampaignsState createState() => _StartedCampaignsState();
}

class _StartedCampaignsState extends State<StartedCampaigns> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: FutureBuilder(
            future: CampaignDatabase().getStartedCampaigns(
                Provider.of<UserProvider>(context, listen: false)
                    .loggedUser
                    .data
                    .id),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: SpinKitChasingDots(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                default:
                  if (snapshot.data == null) {
                    print(snapshot.data);
                    return Text("No data");
                  } else {
                    final _campaign = snapshot.data;
                    print(_campaign);
                    print(_campaign.length);
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _campaign.length,
                        itemBuilder: (context, index) {
                          return Text(index.toString() + " Now");
                        });
                  }
              }
            }));
  }
}
