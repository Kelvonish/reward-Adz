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
      } else if (surveyAnswers.data[index].type == "textfield") {
        if (surveyAnswers.data[index].textFieldAnswer == null) {
          surveyErrors.add("Question $qn is not answered");
        }
      } else if (surveyAnswers.data[index].type == "checkboxes") {
        for (int i = 0; i > surveyAnswers.data[index].answers.length; i++) {
          if (surveyAnswers.data[index].answers[i].selectedAnswer == true) {
            if (surveyAnswers.data[index].answers[i].choice == "incorrect") {
              surveyErrors
                  .add("Selected answer for question $qn is not correct");
            }
          }
        }
      }
    }
    if (surveyErrors.isEmpty) {
      Fluttertoast.showToast(
          msg: "Congratulations! you answered all questions succesfully");
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You have some Errors!!'),
            content: Container(
              width: double.maxFinite,
              //height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: surveyErrors.length,
                  itemBuilder: (context, index) {
                    return Text(surveyErrors[index]);
                  }),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    notifyListeners();
  }
}
