import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCampaignPage extends StatefulWidget {
  @override
  _VideoCampaignPageState createState() => _VideoCampaignPageState();
}

class _VideoCampaignPageState extends State<VideoCampaignPage> {
  VideoPlayerController _controller;
  Future<void> _initializedVideoPlayerFuture;
  bool _videoEnded = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4')
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
                    onTap: () {},
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("Start Survey"),
                          Icon(Icons.arrow_forward)
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
  }
}
