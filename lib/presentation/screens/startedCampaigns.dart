import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/database/campaignDatabase.dart';
import 'package:rewardadz/presentation/widgets/campaignCardDatabase.dart';

class StartedCampaigns extends StatefulWidget {
  @override
  _StartedCampaignsState createState() => _StartedCampaignsState();
}

class _StartedCampaignsState extends State<StartedCampaigns> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Consumer<CampaignDatabaseProvider>(
          builder: (context, value, child) => FutureBuilder(
              future: value.getStartedCampaigns(
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
                    if (snapshot.hasData) {
                      final _campaign = snapshot.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: _campaign.length,
                          itemBuilder: (context, index) {
                            if (_campaign.length == 0) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/startedCampaigns.png"),
                                  Text(
                                      "All the the campaigns you have started will be shown here")
                                ],
                              );
                            } else {
                              return CampaignCardDatabase(
                                amount: _campaign[index]["campaignAmount"],
                                type: _campaign[index]["campaignType"],
                                category: _campaign[index]
                                    ["campaignOrganizationIndustry"],
                                isActive: true,
                                mainUrl: _campaign[index]["campaignMainUrl"],
                                name: _campaign[index]["campaignName"],
                                otherUrl: _campaign[index]
                                    ["campaignOrganizationLogo"],
                                campaignId: _campaign[index]["campaignId"],
                              );
                            }
                          });
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/startedCampaigns.png"),
                          Text(
                              "All the the campaigns you have started will be shown here")
                        ],
                      );
                    }
                }
              }),
        ));
  }
}
