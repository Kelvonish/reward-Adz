import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rewardadz/presentation/widgets/advertismentTileWidget.dart';
import 'package:rewardadz/presentation/widgets/campaignCardShimmer.dart';
import 'package:rewardadz/presentation/widgets/campaignCardTile.dart';
import 'package:rewardadz/presentation/screens/campaignDetail.dart';
import 'package:provider/provider.dart';
import '../../business_logic/providers/getCampaignProvider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    // final campaign = Provider.of<GetCampaignProvider>(context);

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
                Container(
                  alignment: Alignment.topLeft,
                  height: 80,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: AdTile(
                          name: "Facebook",
                          url: "assets/facebook.png",
                        ),
                      ),
                      AdTile(
                        name: "Google",
                        url: "assets/google.png",
                      ),
                      AdTile(
                        name: "Twitter",
                        url: "assets/twitter.png",
                      ),
                    ],
                  ),
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
                /*
                _determineLocationClass.denied
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_off,
                              size: 50,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "Please enable and allow Location services to get campaigns in your locality",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                            TextButton.icon(
                                onPressed: () {
                                  getCampaigns();
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColor)),
                                icon: Icon(
                                  Icons.replay,
                                  color: Colors.white,
                                ),
                                label: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Reload",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ],
                        ),
                      )
                    : */

                Consumer<GetCampaignProvider>(
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
                                    return InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CampaignDetails(
                                                    mainUrl: "assets/agri.jpg",
                                                    otherUrl:
                                                        "assets/picture.png",
                                                    name: "Test Company",
                                                    category:
                                                        "Gaming and Video",
                                                    amount: "60",
                                                    type: "video",
                                                  ))),
                                      child: MainCardTile(
                                        name: data.campaignList[index].title,
                                        mainUrl:
                                            "https://image.tmdb.org/t/p/w500" +
                                                data.campaignList[index]
                                                    .posterPath,
                                        otherUrl:
                                            "https://image.tmdb.org/t/p/w500" +
                                                data.campaignList[index]
                                                    .posterPath,
                                        category: "Gaming and Video",
                                        amount: "60",
                                        type: "video",
                                      ),
                                    );
                                  }),
                    ],
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
