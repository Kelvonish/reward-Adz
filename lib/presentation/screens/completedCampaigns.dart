import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/getCampaignProvider.dart';
import 'package:rewardadz/presentation/widgets/completedCampaignTile.dart';

class CompletedCampaigns extends StatefulWidget {
  @override
  _CompletedCampaignsState createState() => _CompletedCampaignsState();
}

class _CompletedCampaignsState extends State<CompletedCampaigns> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Consumer<GetCampaignProvider>(
          builder: (context, value, child) => value.loadingCompletedCampaigns
              ? Center(
                  child: SpinKitChasingDots(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : value.completedCampaigns == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/completed.png"),
                        Text(
                          "All the campaigns you have completed will be shown here",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  : value.completedCampaigns.data.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/completed.png"),
                            Text(
                              "All the campaigns you have completed will be shown here",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            )
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.completedCampaigns.data.length,
                          itemBuilder: (context, index) {
                            return CompletedCampaignsTile(
                              amount: value
                                  .completedCampaigns.data[index].awards.amount
                                  .toString(),
                              category: value.completedCampaigns.data[index]
                                  .campaign.organization.industry,
                              mainUrl: value.completedCampaigns.data[index]
                                  .campaign.campimg,
                              name: value
                                  .completedCampaigns.data[index].campaign.name,
                              otherUrl: value.completedCampaigns.data[index]
                                  .campaign.organization.logo,
                            );
                          }),
        ));
  }
}
