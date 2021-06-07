import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/presentation/screens/videoQuiz.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class VideoCampaignPage extends StatefulWidget {
  final VideoModel videoModel;
  final String name;
  VideoCampaignPage({this.videoModel, this.name});
  @override
  _VideoCampaignPageState createState() => _VideoCampaignPageState();
}

class _VideoCampaignPageState extends State<VideoCampaignPage> {
  FlickManager flickManager;
  bool _videoEnded = false;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      onVideoEnd: () {
        setState(() {
          _videoEnded = true;
        });
      },
      videoPlayerController:
          VideoPlayerController.network(widget.videoModel.url),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned(
                top: 40,
                left: 15,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              _videoEnded
                  ? Positioned(
                      top: 40,
                      right: 15,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoQuiz(
                                        name: widget.name,
                                        surveyId: widget.videoModel.surveyid,
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text("Start Survey"),
                              SizedBox(
                                width: 5.0,
                              ),
                              CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 10,
                    ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: FlickVideoPlayer(
                    flickManager: flickManager,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*
  FlickManager flickManager;
  VideoPlayerController _controller;
  Future<void> _initializedVideoPlayerFuture;
  bool _videoEnded = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoModel.url)
      ..initialize().then((_) {
        _controller.play();
        setState(() {
          _initializedVideoPlayerFuture = _controller.initialize();
        });
      });

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          _videoEnded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
              left: 15,
              top: 40,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context))),
          _videoEnded
              ? Positioned(
                  top: 40,
                  right: 15,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => VideoQuiz()));
                    },
                    child: Container(
                      width: 125,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("Start Survey"),
                          SizedBox(
                            width: 5.0,
                          ),
                          CircleAvatar(
                              radius: 15,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  width: 10,
                ),
          Center(
            child: FutureBuilder(
              future: _initializedVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Positioned(
              bottom: 15,
              left: 5,
              right: 5,
              child: VideoProgressIndicator(_controller,
                  colors: VideoProgressColors(
                      playedColor: Theme.of(context).primaryColor),
                  allowScrubbing: true)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(() {});
    _controller.dispose();
  }*/
}
