import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/Shared/sortCampaignByType.dart';
import 'package:rewardadz/business_logic/providers/topAdvertisersProvider.dart';

import 'package:rewardadz/presentation/widgets/campaignCardShimmer.dart';

class OrganizationCampaigns extends StatefulWidget {
  final String organizationId;
  final String name;
  final String url;
  final String category;
  OrganizationCampaigns(
      {this.name, this.organizationId, this.url, this.category});
  @override
  _OrganizationCampaignsState createState() => _OrganizationCampaignsState();
}

class _OrganizationCampaignsState extends State<OrganizationCampaigns> {
  @override
  void initState() {
    super.initState();
    Provider.of<TopAdvertisersProvider>(context, listen: false)
        .getOrganizationCampaigns(widget.organizationId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text(
              widget.name + " Campaigns",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black),
                          ),
                          Text(
                            widget.category,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.0,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.url,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Consumer<TopAdvertisersProvider>(
                      builder: (context, data, child) => Column(
                        children: [
                          data.organizationPageLoading
                              ? ListView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return CampaignCardShimmer();
                                  })
                              : data.organizationCampaignsList.length == 0
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      child: Center(
                                        child: Text(
                                          "The organization has not published a campaign yet!",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          data.organizationCampaignsList.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return renderCampaignByType(
                                            context,
                                            data.organizationCampaignsList[
                                                index]);
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
      ),
    );
  }
}
