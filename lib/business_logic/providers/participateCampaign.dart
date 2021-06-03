import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rewardadz/data/models/campaignModel.dart';

class ParticipateCampaignProvider extends ChangeNotifier {
  bool downloading = false;
  downloadAudio(AudioModel audioModel) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      downloading = true;
      notifyListeners();
      final baseStorage = await getExternalStorageDirectory();
      final savedDirectory = Directory(baseStorage.path + "RewardAdz");

      bool hasExisted = await savedDirectory.existsSync();
      if (!hasExisted) {
        savedDirectory.create();
      }
      final taskId = await FlutterDownloader.enqueue(
          url: audioModel.audiourl,
          savedDir: baseStorage.path + "RewardAdz",
          openFileFromNotification: true,
          fileName: "Saf audio");
      print("downloaded file here...");
      print(taskId);
      Fluttertoast.showToast(msg: "Downloaded");
    }
    downloading = false;
    notifyListeners();
  }
}
