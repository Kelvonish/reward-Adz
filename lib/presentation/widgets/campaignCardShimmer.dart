import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CampaignCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[350],
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 200,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(children: []),
        ),
      ),
    );
  }
}
