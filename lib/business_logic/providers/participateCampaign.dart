import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rewardadz/business_logic/providers/notificationsProvider.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/models/surveyModel.dart';

class ParticipateCampaignProvider extends ChangeNotifier {
  bool downloading = false;
  bool sharingbanner = false;
  bool checkingAnswers = false;
  List<String> surveyErrors = [];

  SendNotification notification = SendNotification();
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

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future saveAndShare(BuildContext context, String url, String filename) async {
    Directory directory;
    final RenderBox box = context.findRenderObject();
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "$filename.png");
      if (!await directory.exists()) {
        print("No directory");
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        var response = await get(Uri.parse(url));
        print(response);
        saveFile.writeAsBytesSync(response.bodyBytes);
        Share.shareFiles([directory.path + "$filename.png"],
            text: 'Great picture',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }
    } catch (e) {
      print(e);
    }
  }

  checkVideoAnswers(BuildContext context, FullSurveyModel surveyAnswers) {
    for (int index = 0; index < surveyAnswers.data.length; index++) {
      var qn = index + 1;
      if (surveyAnswers.data[index].type == "radio") {
        if (surveyAnswers.data[index].choosenAnswer == null) {
          if (surveyErrors.contains("Please answer all questions !")) {
          } else {
            surveyErrors.add("Please answer all questions !");
          }
        } else {
          if (surveyAnswers.data[index]
                  .answers[surveyAnswers.data[index].choosenAnswer].choice !=
              "correct") {
            surveyErrors.add("Question $qn is not correct");
          }
        }
      } else if (surveyAnswers.data[index].type == "textfield") {
        if (surveyAnswers.data[index].textFieldAnswer == null) {
          if (surveyErrors.contains("Please answer all questions !")) {
          } else {
            surveyErrors.add("Please answer all questions !");
          }
        }
      } else if (surveyAnswers.data[index].type == "checkboxes") {
        surveyAnswers.data[index].answers.forEach((element) {
          if (element.selectedAnswer == true) {
            if (element.choice != "correct") {
              surveyErrors
                  .add("Selected answer for question $qn is not correct");
            }
          }
        });
      }
    }
    if (surveyErrors.isEmpty) {
      notification.sendNotification(
          "Congratulation! ", "You have earned 30 from video campaign");
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 50,
            )),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: surveyErrors.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(surveyErrors[index]),
                    );
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

  Future<Null> saveAndShare1(BuildContext context, String imageUrl) async {
    //isBtn2 = true;

    final RenderBox box = context.findRenderObject();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      var url = imageUrl;
      var uri = Uri.parse(url);
      var response = await get(uri);
      final documentDirectory =
          await (await getExternalStorageDirectory()).create(recursive: true);

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      print(appDocPath);

      File imgFile = new File('$appDocPath/$url');
      imgFile.writeAsBytesSync(response.bodyBytes);
      Share.shareFiles(['$appDocPath/$url'],
          text: 'Great picture',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      /*Share.shareFile(File('$documentDirectory/$url'),
          subject: 'URL conversion + Share',
          text: 'Hey! Checkout the Share Files repo',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);*/
    }
    Share.share('Hey! Checkout the Share Files repo',
        subject: 'URL conversion + Share',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
