import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/presentation/screens/videoQuiz.dart';
import 'package:video_player/video_player.dart';

class VideoCampaignPage extends StatefulWidget {
  final CampaignModel videoModel;
  final String name;
  VideoCampaignPage({this.videoModel, this.name});
  @override
  _VideoCampaignPageState createState() => _VideoCampaignPageState();
}

class _VideoCampaignPageState extends State<VideoCampaignPage> {
  VideoPlayerController _controller;
  Future<void> _initializedVideoPlayerFuture;
  bool _videoEnded = false;
  bool bufferring = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoModel.video.url)
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
      setState(() {
        bufferring = _controller.value.isBuffering;
      });
    });
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
                                        campaignModel: widget.videoModel,
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
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white10,
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
              bufferring
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white10,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(),
              Positioned(
                  bottom: 40,
                  left: 15,
                  right: 15,
                  child: VideoProgressIndicator(_controller,
                      colors: VideoProgressColors(playedColor: Colors.white),
                      allowScrubbing: false)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_controller.value.isPlaying) _controller.pause();
    _controller.removeListener(() {});
    _controller.dispose();
    _controller = null;
    super.dispose();
  }
}
