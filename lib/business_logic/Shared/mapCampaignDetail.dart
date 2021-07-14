import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../data/database/campaignDatabase.dart';
import '../../data/models/campaignModel.dart';
import '../../presentation/screens/videoCampaign.dart';
import '../../presentation/widgets/audioPlayer.dart';
import '../providers/getCampaignProvider.dart';
import '../providers/participateCampaign.dart';
import '../providers/userProvider.dart';

showSocialShareModal(BuildContext context, CampaignModel campaignModel) {
  showCupertinoModalPopup(
      context: context,
      builder: (context) => Material(
            child: Container(
                padding: EdgeInsets.all(15.0),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Title(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Share to : ',
                          style: TextStyle(fontSize: 18.0),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        await Provider.of<ParticipateCampaignProvider>(context,
                                listen: false)
                            .saveAndShare(
                                context,
                                campaignModel,
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .loggedUser,
                                "Twitter");
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/twitter.png"),
                        ),
                        title: Text("Twitter"),
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        await Provider.of<ParticipateCampaignProvider>(context,
                                listen: false)
                            .saveAndShare(
                                context,
                                campaignModel,
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .loggedUser,
                                "Facebook");
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.facebook,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text("Facebook"),
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                  ],
                )),
          ));
}

Widget checkTypeofCampaignForDetails(String type, CampaignModel campaignModel) {
  if (type == "Ringtone") {
    return Text(
      "Set as ringtone to earn",
      style: TextStyle(fontSize: 13.0, color: Colors.white),
    );
  } else if (type == "Video") {
    return Text(
      "Watch the video and answer questions correctly to earn Ksh " +
          campaignModel.video.watchedvideosamount,
      style: TextStyle(
          fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w300),
    );
  } else if (type == "Survey") {
    return Text(
      "Answer survey questions to earn Ksh " + campaignModel.survey.amount,
      style: TextStyle(
          fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w300),
    );
  } else if (type == "Banner") {
    return Text(
      "Share banner and earn",
      style: TextStyle(fontSize: 13.0, color: Colors.white),
    );
  }
  return null;
}

Widget checkTypeForAction(
    BuildContext context, String type, CampaignModel campaignModel) {
  if (type == "Video") {
    return InkWell(
      onTap: () async {
        bool participated =
            Provider.of<ParticipateCampaignProvider>(context, listen: false)
                .checkParticipation(
                    campaignModel.sId,
                    Provider.of<GetCampaignProvider>(context, listen: false)
                        .completedCampaigns);
        if (participated) {
          Fluttertoast.showToast(
              msg: "You have already participated in the campaign!");
        } else {
          await Provider.of<CampaignDatabaseProvider>(context, listen: false)
              .insertCampaign(
                  campaignModel,
                  Provider.of<UserProvider>(context, listen: false)
                      .loggedUser
                      .data
                      .id);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoCampaignPage(
                        name: campaignModel.name,
                        videoModel: campaignModel,
                      )));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.play_arrow,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Watch Video,",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Watch video and answer subsequent questions to earn Ksh " +
                            campaignModel.video.watchedvideosamount,
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  } else if (type == "Ringtone") {
    return InkWell(
      onTap: () async {
        bool participated =
            Provider.of<ParticipateCampaignProvider>(context, listen: false)
                .checkParticipation(
                    campaignModel.sId,
                    Provider.of<GetCampaignProvider>(context, listen: false)
                        .completedCampaigns);
        if (participated) {
          Fluttertoast.showToast(
              msg: "You have already participated in the campaign!");
        } else {
          await Provider.of<CampaignDatabaseProvider>(context, listen: false)
              .insertCampaign(
                  campaignModel,
                  Provider.of<UserProvider>(context, listen: false)
                      .loggedUser
                      .data
                      .id);
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  color: Colors.white,
                  child: Consumer<ParticipateCampaignProvider>(
                    builder: (context, value, child) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Adopt Ringtone",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.cancel_sharp,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                        Divider(
                          height: 5,
                          color: Colors.grey[400],
                        ),
                        AudioPlayerWidget(audioModel: campaignModel.audio),
                        SizedBox(
                          height: 30,
                        ),
                        TextButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor)),
                            onPressed: () {
                              //value.downloadAudio(campaignModel.audio);
                              Fluttertoast.showToast(
                                  msg: "Not implemented! Coming soon");
                            },
                            icon: Icon(
                              Icons.music_note_outlined,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Set Ringtone",
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(
                          height: 30.0,
                        ),
                        value.downloading
                            ? Container(
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Downloading...",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Text("")
                      ],
                    ),
                  ),
                );
              });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.music_note,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Adopt Ringtone,",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Set ringtone and earn " + campaignModel.audio.award,
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  } else if (type == "Survey") {
    return Consumer<GetCampaignProvider>(
      builder: (context, value, child) => value.loadingSurvey
          ? Center(
              child: SpinKitChasingDots(
              color: Theme.of(context).primaryColor,
            ))
          : InkWell(
              onTap: () async {
                bool participated = Provider.of<ParticipateCampaignProvider>(
                        context,
                        listen: false)
                    .checkParticipation(
                        campaignModel.sId,
                        Provider.of<GetCampaignProvider>(context, listen: false)
                            .completedCampaigns);
                if (participated) {
                  Fluttertoast.showToast(
                      msg: "You have already participated in the campaign!");
                } else {
                  await Provider.of<CampaignDatabaseProvider>(context,
                          listen: false)
                      .insertCampaign(
                          campaignModel,
                          Provider.of<UserProvider>(context, listen: false)
                              .loggedUser
                              .data
                              .id);

                  Provider.of<GetCampaignProvider>(context, listen: false)
                      .getSurvey(
                          context,
                          campaignModel.survey.surveyid,
                          campaignModel.name,
                          Provider.of<UserProvider>(context, listen: false)
                              .loggedUser
                              .token);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).accentColor,
                          child: Icon(
                            Icons.assignment,
                            color: Theme.of(context).primaryColor,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Answer Survey",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Answer survey questions to earn Ksh " +
                                    campaignModel.survey.amount,
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
    );
  } else if (type == "Banner") {
    return InkWell(
      onTap: () async {
        bool participated =
            Provider.of<ParticipateCampaignProvider>(context, listen: false)
                .checkParticipation(
                    campaignModel.sId,
                    Provider.of<GetCampaignProvider>(context, listen: false)
                        .completedCampaigns);
        if (participated) {
          Fluttertoast.showToast(
              msg: "You have already participated in the campaign!");
        } else {
          await Provider.of<CampaignDatabaseProvider>(context, listen: false)
              .insertCampaign(
                  campaignModel,
                  Provider.of<UserProvider>(context, listen: false)
                      .loggedUser
                      .data
                      .id);
          showSocialShareModal(context, campaignModel);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.assignment,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Share Banner",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Share Banner to earn  " +
                            campaignModel.banner.sharesamount,
                        style: TextStyle(fontSize: 13.0, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
  return Text("");
}
