import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/models/campaignModel.dart';

class DownloadAudio extends StatefulWidget {
  final AudioModel audioModel;
  DownloadAudio({this.audioModel});

  @override
  _DownloadAudioState createState() => _DownloadAudioState();
}

class _DownloadAudioState extends State<DownloadAudio> {
  ReceivePort receivePort = ReceivePort();
  int progress = 0;
  void downloadAudio() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      final taskId = await FlutterDownloader.enqueue(
          url: widget.audioModel.audiourl,
          savedDir: baseStorage.path + "/Downloads",
          openFileFromNotification: true,
          fileName: "Saf audio");
      print("downloaded file here...");
      print(taskId);
      Fluttertoast.showToast(msg: "Downloaded");
    }
  }

  @override
  void initState() {
    downloadAudio();
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloading audio");
    receivePort.listen((message) {
      setState(() {
        progress = message;
      });
    });
    FlutterDownloader.registerCallback((id, status, progress) {
      SendPort sendPort =
          IsolateNameServer.lookupPortByName("downloading audio");
      sendPort.send(progress);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
