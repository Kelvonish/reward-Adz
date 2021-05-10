import 'package:flutter/material.dart';
import 'package:rewardadz/presentation/screens/videoCampaign.dart';

class CampaignDetails extends StatefulWidget {
  final String amount;
  final String name;
  final String mainUrl;
  final String otherUrl;
  final String category;
  final String type;

  CampaignDetails(
      {this.amount,
      this.mainUrl,
      this.otherUrl,
      this.category,
      this.name,
      this.type});

  @override
  _CampaignDetailsState createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(widget.mainUrl ?? ""),
                    fit: BoxFit.cover,
                  )),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context)),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                              widget.otherUrl ?? "",
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text(
                                widget.category ?? "",
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
                            child: Text(
                              "70% battery charge * Watch Videos within 5 location * % unique callers * share on your social  media platform",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
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
                widget.type == "video"
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoCampaignPage()));
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
                                      Icons.play_arrow,
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
                                          "Watch Video,",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Watch video and answer subsequent questions to earn",
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
                      )
                    : Padding(
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
                                        "Download the ringtone and use it as\n your ringtone and earn",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Share with friends",
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
                              "Share the ringtone with 5 friends \n and earn Ksh 500",
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
