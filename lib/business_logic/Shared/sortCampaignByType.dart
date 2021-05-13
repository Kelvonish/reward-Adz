import 'package:flutter/material.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/presentation/screens/campaignDetail.dart';
import 'package:rewardadz/presentation/widgets/campaignCardTile.dart';

Widget renderCampaignByType(BuildContext context, CampaignModel data) {
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
