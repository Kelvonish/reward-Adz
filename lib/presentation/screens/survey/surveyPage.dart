import 'package:flutter/material.dart';

import 'package:rewardadz/data/models/surveyModel.dart';

class Survey extends StatefulWidget {
  final FullSurveyModel surveyModel;
  final String pageTitle;
  Survey({this.surveyModel, this.pageTitle});
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  var radioGroupValue;
  var selectedRadio;
  @override
  Widget build(BuildContext context) {
    _buildAnswers(BuildContext context, Data data) {
      if (data.type == "radio") {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: data.answers.length,
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
                      data.answers[index].title,
                      style: selectedRadio == data.answers[index].title
                          ? TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white)
                          : TextStyle(fontWeight: FontWeight.normal),
                    ),
                    activeColor: Colors.white,
                    value: data.answers[index].title,
                    toggleable: true,
                    groupValue: radioGroupValue,
                    selected: selectedRadio == data.answers[index].title
                        ? true
                        : false,
                    controlAffinity: ListTileControlAffinity.trailing,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onChanged: (val) {
                      setState(() {
                        selectedRadio = val;
                        print(selectedRadio);
                      });
                    }),
              );
            });
      } else if (data.type == "textfield") {
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: TextFormField(
            cursorColor: Theme.of(context).primaryColor,
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
      } else if (data.type == "checkboxes") {
        bool _value = false;
        return ListView.builder(
            shrinkWrap: true,
            itemCount: data.answers.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: CheckboxListTile(
                  selectedTileColor: Theme.of(context).primaryColor,
                  tileColor: Colors.grey[200],
                  title: Text(
                    data.answers[index].title,
                    style: _value
                        ? TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)
                        : TextStyle(fontWeight: FontWeight.normal),
                  ),
                  autofocus: false,
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.trailing,
                  selected: _value,
                  value: _value,
                  onChanged: (bool value) {
                    setState(() {
                      _value = value;
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
              widget.pageTitle,
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.surveyModel.data.length,
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
                                widget.surveyModel.data.length.toString()),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.surveyModel.data[index].question,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.0),
                            ),
                            _buildAnswers(
                              context,
                              widget.surveyModel.data[index],
                            ),
                          ],
                        );
                      }),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor)),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Submit"),
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
