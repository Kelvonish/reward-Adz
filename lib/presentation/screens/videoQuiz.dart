import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/getCampaignProvider.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/data/models/surveyModel.dart';

import '../../business_logic/providers/participateCampaign.dart';

class VideoQuiz extends StatefulWidget {
  final String surveyId;
  final String name;
  VideoQuiz({this.surveyId, this.name});

  @override
  _VideoQuizState createState() => _VideoQuizState();
}

class _VideoQuizState extends State<VideoQuiz> {
  FullSurveyModel surveyAnswers = FullSurveyModel(data: []);
  @override
  void initState() {
    super.initState();
    Provider.of<GetCampaignProvider>(context, listen: false)
        .getVideoSurvey(widget.surveyId);
  }

  @override
  void dispose() {
    Provider.of<ParticipateCampaignProvider>(context, listen: false)
        .surveyErrors = [];

    super.dispose();
    surveyAnswers.data = [];
  }

  @override
  Widget build(BuildContext context) {
    _buildAnswers(
        BuildContext context, SurveyDataModel answerData, int position) {
      if (surveyAnswers.data.contains(answerData)) {
      } else {
        surveyAnswers.data.add(answerData);
      }
      if (answerData.type == "radio") {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: answerData.answers.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: RadioListTile(
                    selectedTileColor: Theme.of(context).primaryColor,
                    tileColor: Colors.grey[200],
                    title: Text(
                      answerData.answers[index].title,
                      style: surveyAnswers.data[position].choosenAnswer == index
                          ? TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white)
                          : TextStyle(fontWeight: FontWeight.normal),
                    ),
                    activeColor: Colors.white,
                    value: answerData.answers[index].title,
                    toggleable: true,
                    groupValue: answerData.sId,
                    selected:
                        surveyAnswers.data[position].choosenAnswer == index
                            ? true
                            : false,
                    controlAffinity: ListTileControlAffinity.trailing,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onChanged: (val) {
                      setState(() {
                        surveyAnswers.data[position].choosenAnswer = index;
                      });
                    }),
              );
            });
      } else if (answerData.type == "textfield") {
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: TextFormField(
            cursorColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              surveyAnswers.data[position].textFieldAnswer = value;
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
              hintText: "Write an answer",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              fillColor: Colors.grey[100],
              filled: true,
            ),
          ),
        );
      } else if (answerData.type == "checkboxes") {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: answerData.answers.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: CheckboxListTile(
                  selectedTileColor: Theme.of(context).primaryColor,
                  tileColor: Colors.grey[200],
                  title: Text(
                    answerData.answers[index].title,
                    style: surveyAnswers
                            .data[position].answers[index].selectedAnswer
                        ? TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)
                        : TextStyle(fontWeight: FontWeight.normal),
                  ),
                  autofocus: false,
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.trailing,
                  selected: surveyAnswers
                      .data[position].answers[index].selectedAnswer,
                  value: surveyAnswers
                      .data[position].answers[index].selectedAnswer,
                  onChanged: (bool val) {
                    setState(() {
                      surveyAnswers
                          .data[position].answers[index].selectedAnswer = val;
                    });
                  },
                ),
              );
            });
      }
    }

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              widget.name,
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.all(10.0),
            child: Consumer<GetCampaignProvider>(
              builder: (context, value, child) => value.loadingSurvey
                  ? Center(
                      child: SpinKitChasingDots(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : ListView(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.videoSurvey.data.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var questionNumber = index + 1;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text("Question " +
                                      questionNumber.toString() +
                                      "/" +
                                      value.videoSurvey.data.length.toString()),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    value.videoSurvey.data[index].question,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                  _buildAnswers(context,
                                      value.videoSurvey.data[index], index),
                                ],
                              );
                            }),
                        Consumer<ParticipateCampaignProvider>(
                          builder: (context, value, child) => Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 30.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor)),
                              onPressed: () {
                                value.surveyErrors = [];
                                print(" Length od answers " +
                                    surveyAnswers.data.length.toString());
                                value.checkVideoAnswers(context, surveyAnswers);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("Submit"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
