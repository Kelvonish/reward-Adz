import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/presentation/widgets/completedCampaignTile.dart';
import 'package:rewardadz/data/database/campaignDatabase.dart';

class CompletedCampaigns extends StatefulWidget {
  @override
  _CompletedCampaignsState createState() => _CompletedCampaignsState();
}

class _CompletedCampaignsState extends State<CompletedCampaigns> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Consumer<CampaignDatabaseProvider>(
          builder: (context, value, child) => FutureBuilder(
              future: value.getCompletedCampaigns(
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
                      return _campaign.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/completed.png"),
                                Text(
                                  "All the campaigns you have started will be shown here",
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                )
                              ],
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _campaign.length,
                              itemBuilder: (context, index) {
                                return CompletedCampaignsTile(
                                  amount: _campaign[index]["campaignAmount"],
                                  type: _campaign[index]["campaignType"],
                                  category: _campaign[index]
                                      ["campaignOrganizationIndustry"],
                                  mainUrl: _campaign[index]["campaignMainUrl"],
                                  name: _campaign[index]["campaignName"],
                                  otherUrl: _campaign[index]
                                      ["campaignOrganizationLogo"],
                                );
                              });
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/completed.png"),
                          Text(
                              "All the campaigns you have started will be shown here")
                        ],
                      );
                    }
                }
              }),
        ));
  }
}
