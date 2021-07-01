import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CompletedCampaignsTile extends StatelessWidget {
  final String mainUrl;
  final String otherUrl;
  final String name;
  final String category;
  final String amount;
  final String type;
  CompletedCampaignsTile(
      {this.amount,
      this.category,
      this.mainUrl,
      this.name,
      this.otherUrl,
      this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: mainUrl,
              fit: BoxFit.fitHeight,
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                  //shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              placeholder: (context, url) => SpinKitChasingDots(
                color: Theme.of(context).primaryColor,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: otherUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            category,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.0,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        "Earned KSh $amount",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
