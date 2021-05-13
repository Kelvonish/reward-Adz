import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdTile extends StatelessWidget {
  final String url;
  final String name;
  AdTile({this.name, this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => SpinKitChasingDots(
              color: Theme.of(context).primaryColor,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
