import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rewardadz/business_logic/providers/checkInternetProvider.dart';
import 'package:rewardadz/business_logic/providers/notificationsProvider.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/models/surveyModel.dart';

class ParticipateCampaignProvider extends ChangeNotifier {
  bool downloading = false;
  bool sharingbanner = false;
  bool checkingAnswers = false;
  List<String> surveyErrors = [];
  bool isInternetConnected;
  TextEditingController _linkController = TextEditingController();

  checkInternetConnection() async {
    isInternetConnected = await ConnectivityService().checkInternetConnection();
    notifyListeners();
  }

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

      final taskId = await FlutterDownloader.enqueue(
          url: audioModel.audiourl,
          savedDir: baseStorage.path,
          openFileFromNotification: true,
          fileName: "Saf audio.mp3");
      print("downloaded file here...");
      print(taskId);
      Fluttertoast.showToast(msg: "Downloaded");
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
          Fluttertoast.showToast(msg: "Permission not granted");
        }
      }
      File saveFile = File(directory.path + "$filename.png");
      if (!await directory.exists()) {
        print("No directory");
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await checkInternetConnection();
        if (isInternetConnected == false) {
          Fluttertoast.showToast(msg: "No internet connection");
        } else {
          sharingbanner = true;
          notifyListeners();

          var response = await get(Uri.parse(url));

          saveFile.writeAsBytesSync(response.bodyBytes);
          Share.shareFiles([directory.path + "$filename.png"],
              text: '#rewardAdz #Earn',
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          showCupertinoModalPopup(
              context: context,
              builder: (context) => Container(
                    margin: EdgeInsets.all(15.0),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                          margin: MediaQuery.of(context).viewInsets,
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Submit Shared Post Link",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                ),
                              )),
                              Divider(
                                height: 5,
                              ),
                              Form(
                                child: TextFormField(
                                  validator: (value) => value.isEmpty
                                      ? "Please Enter a valid link"
                                      : null,
                                  controller: _linkController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Enter Link",
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(0.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    bool _validURL =
                                        Uri.parse(_linkController.text)
                                            .isAbsolute;
                                    if (_validURL) {
                                      if (_linkController.text
                                          .contains("twitter.com")) {
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "That is not a link to the twitter post");
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please enter a valid link");
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text("Verify"),
                                  ),
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0.0),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                0.0,
                                              ),
                                              side: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context).primaryColor)),
                                ),
                              )
                            ],
                          )),
                    ),
                  ));
          sharingbanner = false;
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
    sharingbanner = false;
    notifyListeners();
  }

  checkVideoAnswers(BuildContext context, FullSurveyModel surveyAnswers,
      String name, String amount, String user) {
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
        } else if (surveyAnswers.data[index].textFieldAnswer.length < 5) {
          if (surveyErrors.contains("Please answer all questions !")) {
          } else {
            surveyErrors.add("Answer for question $qn not valid !");
          }
        }
      } else if (surveyAnswers.data[index].type == "checkboxes") {
        if (surveyAnswers.data[index].choosenAnswer != null) {
          surveyAnswers.data[index].answers.forEach((element) {
            if (element.selectedAnswer == true) {
              if (element.choice != "correct") {
                surveyErrors
                    .add("Selected answer for question $qn is not correct");
              }
            }
          });
        } else {
          if (surveyErrors.contains("Please answer all questions !")) {
          } else {
            surveyErrors.add("Please answer all questions !");
          }
        }
      }
    }
    if (surveyErrors.isEmpty) {
      Random random = new Random();
      int randomNumber = random.nextInt(100);
      notification.sendNotification("Congratulations $user",
          "You have earned $amount from $name", randomNumber);
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
}
