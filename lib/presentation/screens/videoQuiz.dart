import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/getCampaignProvider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/data/models/surveyModel.dart';
import '../../business_logic/providers/participateCampaign.dart';

class VideoQuiz extends StatefulWidget {
  final String surveyId;
  final String name;
  final String amount;
  VideoQuiz({this.surveyId, this.name, this.amount});

  @override
  _VideoQuizState createState() => _VideoQuizState();
}

class _VideoQuizState extends State<VideoQuiz> {
  FullSurveyModel surveyAnswers = FullSurveyModel();
  @override
  void initState() {
    super.initState();
    initializeState();
  }

  initializeState() async {
    await Provider.of<GetCampaignProvider>(context, listen: false)
        .getVideoSurvey(widget.surveyId);
    setState(() {
      surveyAnswers =
          Provider.of<GetCampaignProvider>(context, listen: false).videoSurvey;
    });
  }

  @override
  void dispose() {
    Provider.of<ParticipateCampaignProvider>(context, listen: false)
        .surveyErrors = [];

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildAnswers(BuildContext context, int position) {
      if (surveyAnswers.data[position].type == "radio") {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: surveyAnswers.data[position].answers.length,
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
                      surveyAnswers.data[position].answers[index].title,
                      style: surveyAnswers.data[position].choosenAnswer == index
                          ? TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white)
                          : TextStyle(fontWeight: FontWeight.normal),
                    ),
                    activeColor: Colors.white,
                    value: surveyAnswers.data[position].answers[index].title,
                    toggleable: true,
                    groupValue: surveyAnswers.data[position].sId,
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
      } else if (surveyAnswers.data[position].type == "textfield") {
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
      } else if (surveyAnswers.data[position].type == "checkboxes") {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: surveyAnswers.data[position].answers.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: CheckboxListTile(
                  selectedTileColor: Theme.of(context).primaryColor,
                  tileColor: Colors.grey[200],
                  title: Text(
                    surveyAnswers.data[position].answers[index].title,
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
                      surveyAnswers.data[position].choosenAnswer = 1;
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
            leading: IconButton(
              onPressed: () {
                final nav = Navigator.of(context);
                nav.pop();
                nav.pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
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
                            itemCount: surveyAnswers.data.length,
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
                                      surveyAnswers.data.length.toString()),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    surveyAnswers.data[index].question,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                  _buildAnswers(context, index),
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
                                value.checkVideoAnswers(
                                    context,
                                    surveyAnswers,
                                    widget.name,
                                    widget.amount,
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .loggedUser
                                        .data
                                        .fname);
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
