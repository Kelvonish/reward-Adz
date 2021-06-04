import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rewardadz/data/models/campaignModel.dart';

import '../../data/models/surveyModel.dart';

class ParticipateCampaignProvider extends ChangeNotifier {
  bool downloading = false;
  bool checkingAnswers = false;
  List<String> surveyErrors = [];
  downloadAudio(AudioModel audioModel) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      downloading = true;
      notifyListeners();
      final baseStorage = await getExternalStorageDirectory();
      final savedDirectory = Directory(baseStorage.path);

      bool hasExisted = savedDirectory.existsSync();
      if (!hasExisted) {
        savedDirectory.create();
      }

      /*
      final taskId = await FlutterDownloader.enqueue(
          url: audioModel.audiourl,
          savedDir: baseStorage.path,
          openFileFromNotification: true,
          fileName: "Saf audio");
      print("downloaded file here...");
      print(taskId);
      Fluttertoast.showToast(msg: "Downloaded");
      */

    }
    downloading = false;
    notifyListeners();
  }

  checkVideoAnswers(BuildContext context, FullSurveyModel surveyAnswers) {
    for (int index = 0; index < surveyAnswers.data.length; index++) {
      var qn = index + 1;
      if (surveyAnswers.data[index].type == "radio") {
        if (surveyAnswers.data[index].choosenAnswer == null) {
          surveyErrors.add("Question $qn is not answered");
        } else {
          if (surveyAnswers.data[index]
                  .answers[surveyAnswers.data[index].choosenAnswer].choice !=
              "correct") {
            surveyErrors.add("Question $qn is not correct");
          }
        }
      }
    }
    if (surveyErrors.isEmpty) {
      Fluttertoast.showToast(
          msg: "Congratulations! you answered all questions succesfully");
    } else {
      // set up the button
      Widget okButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("You have errors!!"),
        content: ListView.builder(itemBuilder: (context, index) {
          return Text(surveyErrors[index]);
        }),
        actions: [
          okButton,
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
  }
}
