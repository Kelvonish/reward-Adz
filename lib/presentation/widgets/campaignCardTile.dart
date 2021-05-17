import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainCardTile extends StatelessWidget {
  final String mainUrl;
  final String otherUrl;
  final String name;
  final String category;
  final String amount;
  final String type;
  final bool isActive;

  MainCardTile(
      {this.mainUrl,
      this.otherUrl,
      this.name,
      this.isActive,
      this.category,
      this.amount,
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
                          Container(
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                type,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
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
