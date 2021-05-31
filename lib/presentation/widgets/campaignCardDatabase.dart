import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/data/database/campaignDatabase.dart';

class CampaignCardDatabase extends StatelessWidget {
  final String mainUrl;
  final String otherUrl;
  final String name;
  final String category;
  final String amount;
  final String type;
  final bool isActive;
  final String campaignId;
  CampaignCardDatabase(
      {this.amount,
      this.category,
      this.isActive,
      this.mainUrl,
      this.name,
      this.otherUrl,
      this.campaignId,
      this.type});
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: isActive
          ? ColorFilter.mode(
              Colors.transparent,
              BlendMode.multiply,
            )
          : ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: mainUrl,
              fit: BoxFit.fitHeight,
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  //shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Earn Ksh $amount",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                Icon(
                                  Icons.offline_bolt,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15.0),
                      color: Colors.black38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: otherUrl,
                                imageBuilder: (context, imageProvider) =>
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    category,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.0,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirm Remove'),
                                      content: Text(
                                          'Are you sure you want to remove ?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancel',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          onPressed: () async {
                                            int success = await Provider.of<
                                                        CampaignDatabaseProvider>(
                                                    context,
                                                    listen: false)
                                                .delete(campaignId);
                                            if (success != null) {
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: Text('Remove')),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              placeholder: (context, url) => SpinKitChasingDots(
                color: Theme.of(context).primaryColor,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}
