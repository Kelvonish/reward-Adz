import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/presentation/widgets/advertismentTileWidget.dart';
import 'package:rewardadz/presentation/widgets/campaignCardShimmer.dart';
import 'package:rewardadz/presentation/widgets/campaignCardTile.dart';
import 'package:rewardadz/presentation/screens/campaignDetail.dart';
import 'package:provider/provider.dart';
import '../../business_logic/providers/getCampaignProvider.dart';
import '../../business_logic/providers/topAdvertisersProvider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle _titleStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    Provider.of<GetCampaignProvider>(context, listen: false)
        .getCampaignsProvider();
    Provider.of<TopAdvertisersProvider>(context, listen: false)
        .getTopAdvertisers();
  }

  @override
  Widget build(BuildContext context) {
    Widget _renderCampaignByType(CampaignModel data) {
      if (data.audio != null) {
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CampaignDetails(
                        mainUrl: data.campimg,
                        otherUrl: data.organization.logo,
                        name: data.name,
                        category: data.organization.industry,
                        amount: data.audio.award,
                        type: "Ringtone",
                        videoModel: null,
                      ))),
          child: MainCardTile(
            name: data.name,
            mainUrl: data.campimg,
            otherUrl: data.organization.logo,
            category: data.organization.industry,
            amount: data.audio.award,
            type: "Ringtone",
          ),
        );
      } else if (data.video != null) {
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CampaignDetails(
                        mainUrl: data.campimg,
                        otherUrl: data.organization.logo,
                        name: data.name,
                        category: data.organization.industry,
                        amount: data.video.watchedvideosamount,
                        type: "Video",
                        videoModel: data.video,
                      ))),
          child: MainCardTile(
            name: data.name,
            mainUrl: data.campimg,
            otherUrl: data.organization.logo,
            category: data.organization.industry,
            amount: data.video.watchedvideosamount,
            type: "Video",
          ),
        );
      } else if (data.survey != null) {
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CampaignDetails(
                        mainUrl: data.campimg,
                        otherUrl: data.organization.logo,
                        name: data.name,
                        category: data.organization.industry,
                        amount: data.survey.amount,
                        type: "Survey",
                        videoModel: null,
                      ))),
          child: MainCardTile(
            name: data.name,
            mainUrl: data.campimg,
            otherUrl: data.organization.logo,
            category: data.organization.industry,
            amount: data.survey.amount,
            type: "Survey",
          ),
        );
      }
      return Text("");
    }

    return RefreshIndicator(
      backgroundColor: Theme.of(context).primaryColor,
      onRefresh: () {
        return Provider.of<GetCampaignProvider>(context, listen: false)
            .getCampaignsProvider();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.person_outline,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              "Balance",
                              style: _titleStyle,
                            ),
                            Text(
                              "Kes 0.00",
                              style: _titleStyle,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Top Advertisers",
                    style: _titleStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Consumer<TopAdvertisersProvider>(
                  builder: (context, value, child) => Container(
                      alignment: Alignment.topLeft,
                      height: 80,
                      child: ListView.builder(
                          itemCount: value.topAdvertisersList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return AdTile(
                                name: value.topAdvertisersList[index].name,
                                url: value.topAdvertisersList[index].logo);
                          })),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Campaigns",
                    style: _titleStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Consumer<GetCampaignProvider>(
                    builder: (context, data, child) => Column(
                      children: [
                        data.loading
                            ? ListView.builder(
                                itemCount: 3,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CampaignCardShimmer();
                                })
                            : data.campaignList.length == 0
                                ? Center(
                                    child: Text(
                                      "No Campaigns available right now!",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.campaignList.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return _renderCampaignByType(
                                          data.campaignList[index]);
                                    }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
