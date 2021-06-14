import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:rewardadz/business_logic/Shared/mapCampaignDetail.dart';
import '../../business_logic/providers/dynamicLinksProvider.dart';
import '../../business_logic/providers/getCampaignProvider.dart';
import '../../business_logic/providers/participateCampaign.dart';

class LinkCampaignDetails extends StatefulWidget {
  final String campaignId;
  final String campaignType;
  LinkCampaignDetails({this.campaignId, this.campaignType});

  @override
  _LinkCampaignDetailsState createState() => _LinkCampaignDetailsState();
}

class _LinkCampaignDetailsState extends State<LinkCampaignDetails> {
  @override
  void initState() {
    super.initState();
    initializeClass();
  }

  initializeClass() async {
    await Provider.of<GetCampaignProvider>(context, listen: false)
        .getSingleCampaign(widget.campaignId,
            Provider.of<UserProvider>(context, listen: false).loggedUser.token);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Consumer<GetCampaignProvider>(
                builder: (context, value, child) => Column(
                  children: [
                    value.loadingCampaignDetails
                        ? Center(
                            child: SpinKitChasingDots(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: value.linkCampaignDetails.campimg,
                                fit: BoxFit.fitHeight,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    //shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black26,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context)),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: value.linkCampaignDetails
                                              .organization.logo,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.linkCampaignDetails.name ??
                                                  "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                            ),
                                            Text(
                                              value.linkCampaignDetails
                                                      .organization.industry ??
                                                  "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10.0),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.0),
                                color: const Color.fromRGBO(114, 145, 219, 1),
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.campaign,
                                        color: Theme.of(context).primaryColor,
                                        size: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Campaign Criteria,",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: checkTypeofCampaignForDetails(
                                              widget.campaignType,
                                              value.linkCampaignDetails),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Divider(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "How to earn money",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                    Icon(
                                      Icons.help_outline,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 10,
                              ),
                              checkTypeForAction(context, widget.campaignType,
                                  value.linkCampaignDetails),
                              InkWell(
                                onTap: () async {
                                  final RenderBox box =
                                      context.findRenderObject();
                                  String dynamicLink =
                                      await DynamicLinkService(context: context)
                                          .createCampaignLink(
                                              value.linkCampaignDetails.sId,
                                              widget.campaignType);
                                  Share.share(dynamicLink,
                                      sharePositionOrigin:
                                          box.localToGlobal(Offset.zero) &
                                              box.size);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: const Color.fromRGBO(
                                            114, 145, 219, 1),
                                        child: Icon(
                                          Icons.share,
                                          color: Theme.of(context).primaryColor,
                                          size: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      InkWell(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Share with friends",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                              Consumer<ParticipateCampaignProvider>(
                                  builder: (context, value, child) =>
                                      value.sharingbanner
                                          ? Center(
                                              child: SpinKitChasingDots(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            )
                                          : Text(""))
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
