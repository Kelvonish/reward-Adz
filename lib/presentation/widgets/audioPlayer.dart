import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:just_audio/just_audio.dart';
import 'package:rewardadz/data/models/campaignModel.dart';

class AudioPlayerWidget extends StatefulWidget {
  final AudioModel audioModel;
  AudioPlayerWidget({this.audioModel});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer _audioPlayer;
  bool playing;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Set a sequence of audio sources that will be played by the audio player.
    _audioPlayer.setUrl(widget.audioModel.audiourl).catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget _playerButton(PlayerState playerState) {
    // 1
    final processingState = playerState?.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      // 2
      return Container(
        margin: EdgeInsets.all(8.0),
        width: 30.0,
        height: 30.0,
        child: SpinKitChasingDots(
          color: Theme.of(context).primaryColor,
        ),
      );
    } else if (_audioPlayer.playing != true) {
      // 3
      return IconButton(
        icon: Icon(
          Icons.play_arrow,
          color: Theme.of(context).primaryColor,
        ),
        iconSize: 30.0,
        onPressed: _audioPlayer.play,
      );
    } else if (processingState != ProcessingState.completed) {
      // 4
      return IconButton(
        icon: Icon(Icons.pause, color: Theme.of(context).primaryColor),
        iconSize: 30.0,
        onPressed: _audioPlayer.pause,
      );
    } else {
      // 5
      return IconButton(
        icon: Icon(Icons.replay, color: Theme.of(context).primaryColor),
        iconSize: 30.0,
        onPressed: () => _audioPlayer.seek(Duration.zero,
            index: _audioPlayer.effectiveIndices.first),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: StreamBuilder<PlayerState>(
        stream: _audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _playerButton(playerState),
              _audioPlayer.playing == true
                  ? SpinKitWave(
                      size: 60,
                      color: Theme.of(context).primaryColor,
                    )
                  : Image.asset(
                      "assets/audio.png",
                      height: 100,
                      width: 120,
                    ),
            ],
          );
        },
      ),
    );
  }
}
