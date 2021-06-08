import 'package:flutter/material.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/presentation/screens/campaignDetail.dart';
import 'package:rewardadz/presentation/widgets/campaignCardTile.dart';

Widget renderCampaignByType(BuildContext context, CampaignModel data) {
  if (data.audio != null) {
    return InkWell(
      onTap: () {
        bool t = true;
        t
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CampaignDetails(
                          type: "Ringtone",
                          campaignModel: data,
                        )))
            : showAlertDialogBox(context);
      },
      child: MainCardTile(
        name: data.name,
        mainUrl: data.campimg,
        isActive: data.isactive,
        otherUrl: data.organization.logo,
        category: data.organization.industry,
        amount: data.audio.award,
        type: "Ringtone",
      ),
    );
  } else if (data.video != null) {
    return InkWell(
      onTap: () {
        bool t = true;
        t
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CampaignDetails(
                          type: "Video",
                          campaignModel: data,
                        )))
            : showAlertDialogBox(context);
      },
      child: MainCardTile(
        name: data.name,
        mainUrl: data.campimg,
        isActive: data.isactive,
        otherUrl: data.organization.logo,
        category: data.organization.industry,
        amount: data.video.watchedvideosamount,
        type: "Video",
      ),
    );
  } else if (data.survey != null) {
    return InkWell(
      onTap: () {
        bool t = true;
        t
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CampaignDetails(
                          type: "Survey",
                          campaignModel: data,
                        )))
            : showAlertDialogBox(context);
      },
      child: MainCardTile(
        name: data.name,
        mainUrl: data.campimg,
        isActive: data.isactive,
        otherUrl: data.organization.logo,
        category: data.organization.industry,
        amount: data.survey.amount,
        type: "Survey",
      ),
    );
  } else if (data.banner != null) {
    return InkWell(
      onTap: () {
        bool t = true;
        t
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CampaignDetails(
                          type: "Banner",
                          campaignModel: data,
                        )))
            : showAlertDialogBox(context);
      },
      child: MainCardTile(
        name: data.name,
        mainUrl: data.campimg,
        isActive: data.isactive,
        otherUrl: data.organization.logo,
        category: data.organization.industry,
        amount: data.banner.sharesamount,
        type: "Banner",
      ),
    );
  }
  return Text("");
}

showAlertDialogBox(BuildContext context) {
  // set up the buttons

  Widget continueButton = TextButton(
    child: Text(
      "I understand",
      style: TextStyle(color: Theme.of(context).primaryColor),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Campaign not active"),
    content: Text(
        "Campaign is currently not active. Try again after 12:00 AM midnight"),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
