import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/getCampaignProvider.dart';
import 'package:rewardadz/business_logic/providers/participateCampaign.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/database/campaignDatabase.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/presentation/screens/videoCampaign.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rewardadz/presentation/widgets/audioPlayer.dart';
import 'package:rewardadz/presentation/widgets/downloadAudio.dart';

class CampaignDetails extends StatefulWidget {
  final String type;

  final CampaignModel campaignModel;

  CampaignDetails({
    this.type,
    this.campaignModel,
  });

  @override
  _CampaignDetailsState createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    Widget _checkTypeofCampaignForDetails() {
      if (widget.type == "Ringtone") {
        return Text(
          "Set as ringtone to earn",
          style: TextStyle(fontSize: 13.0, color: Colors.white),
        );
      } else if (widget.type == "Video") {
        return Text(
          "Watch the video and answer questions correctly to earn Ksh " +
              widget.campaignModel.video.watchedvideosamount,
          style: TextStyle(
              fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w300),
        );
      } else if (widget.type == "Survey") {
        return Text(
          "Answer survey questions to earn Ksh " +
              widget.campaignModel.survey.amount,
          style: TextStyle(
              fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w300),
        );
      } else if (widget.type == "Banner") {
        return Text(
          "Share banner and earn",
          style: TextStyle(fontSize: 13.0, color: Colors.white),
        );
      }
      return null;
    }

    Widget _checkTypeForAction() {
      if (widget.type == "Video") {
        return InkWell(
          onTap: () async {
            await Provider.of<CampaignDatabaseProvider>(context, listen: false)
                .insertCampaign(
                    widget.campaignModel,
                    Provider.of<UserProvider>(context, listen: false)
                        .loggedUser
                        .data
                        .id);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoCampaignPage(
                          name: widget.campaignModel.name,
                          videoModel: widget.campaignModel.video,
                        )));
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
                      backgroundColor: const Color.fromRGBO(114, 145, 219, 1),
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
                                widget.campaignModel.video.watchedvideosamount,
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
      } else if (widget.type == "Ringtone") {
        return InkWell(
          onTap: () async {
            await Provider.of<CampaignDatabaseProvider>(context, listen: false)
                .insertCampaign(
                    widget.campaignModel,
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
                          AudioPlayerWidget(
                              audioModel: widget.campaignModel.audio),
                          SizedBox(
                            height: 30,
                          ),
                          TextButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor)),
                              onPressed: () {
                                value.downloadAudio(widget.campaignModel.audio);
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
                      backgroundColor: const Color.fromRGBO(114, 145, 219, 1),
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
                            "Set ringtone and earn " +
                                widget.campaignModel.audio.award,
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
      } else if (widget.type == "Survey") {
        return Consumer<GetCampaignProvider>(
          builder: (context, value, child) => value.loadingSurvey
              ? Center(
                  child: SpinKitChasingDots(
                  color: Theme.of(context).primaryColor,
                ))
              : InkWell(
                  onTap: () async {
                    await Provider.of<CampaignDatabaseProvider>(context,
                            listen: false)
                        .insertCampaign(
                            widget.campaignModel,
                            Provider.of<UserProvider>(context, listen: false)
                                .loggedUser
                                .data
                                .id);

                    Provider.of<GetCampaignProvider>(context, listen: false)
                        .getSurvey(
                            context,
                            widget.campaignModel.survey.surveyid,
                            widget.campaignModel.name);
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
                              backgroundColor:
                                  const Color.fromRGBO(114, 145, 219, 1),
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
                                        widget.campaignModel.survey.amount,
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
      } else if (widget.type == "Banner") {
        return InkWell(
          onTap: () async {
            await Provider.of<CampaignDatabaseProvider>(context, listen: false)
                .insertCampaign(
                    widget.campaignModel,
                    Provider.of<UserProvider>(context, listen: false)
                        .loggedUser
                        .data
                        .id);

            Provider.of<ParticipateCampaignProvider>(context, listen: false)
                .saveAndShare(context, widget.campaignModel.banner.bannerurl,
                    widget.campaignModel.sId);
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
                      backgroundColor: const Color.fromRGBO(114, 145, 219, 1),
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
                                widget.campaignModel.banner.sharesamount,
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.black),
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

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.campaignModel.campimg,
                  fit: BoxFit.fitHeight,
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
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
                            onPressed: () => Navigator.pop(context)),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: widget.campaignModel.organization.logo,
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
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.campaignModel.name ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text(
                                widget.campaignModel.organization.industry ??
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: _checkTypeofCampaignForDetails(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "How to earn money",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
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
                _checkTypeForAction(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color.fromRGBO(114, 145, 219, 1),
                        child: Icon(
                          Icons.share,
                          color: Theme.of(context).primaryColor,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Share with friends",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Consumer<ParticipateCampaignProvider>(
                    builder: (context, value, child) => value.sharingbanner
                        ? Center(
                            child: SpinKitChasingDots(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : Text(""))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
