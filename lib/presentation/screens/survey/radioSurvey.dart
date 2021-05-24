import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/data/models/surveyModel.dart';
/*
class RadioSurvey extends StatefulWidget {
 FullSurveyModel
    RadioSurvey({this.surveyModel});
    @override
    _RadioSurveyState createState() => _RadioSurveyState();
  }
  
  class FullSurveyModel {
}

class _RadioSurveyState extends State<RadioSurvey> {
  String _selectValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        ListView.builder(
            itemCount: widget.surveyModel.data[0].answers.length,
            itemBuilder: (context, index) => Container(
                  color: Colors.grey[100],
                  child: RadioListTile(
                      value: widget.surveyModel.data[0].answers[index].title,
                      groupValue: _selectValue,
                      onChanged: (val) {
                        setState(() {
                          _selectValue = val;
                        });
                      }),
                ))
      ],
    );
  }

}
*/
