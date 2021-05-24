import 'package:flutter/material.dart';

import 'package:rewardadz/data/models/surveyModel.dart';

class Survey extends StatefulWidget {
  final FullSurveyModel surveyModel;
  Survey({this.surveyModel});
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  _buildAnswers(List<Answers> answers, String type) {
    if (type == "radio") {
      var _groupValue;
      var _selected;
      ListView.builder(
          itemCount: answers.length,
          itemBuilder: (context, index) {
            return RadioListTile(
                value: answers[index].title,
                groupValue: _groupValue,
                onChanged: (val) {
                  setState(() {
                    _selected = val;
                  });
                });
          });
    } else if (type == "textfield") {
      return TextFormField(
        decoration: InputDecoration(fillColor: Colors.grey[100], filled: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.surveyModel.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Question " +
                                index.toString() +
                                "/" +
                                widget.surveyModel.data.length.toString()),
                            Text(
                              widget.surveyModel.data[index].question,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            _buildAnswers(
                                widget.surveyModel.data[index].answers,
                                widget.surveyModel.data[index].type),
                          ],
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
