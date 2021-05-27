class FullSurveyModel {
  String status;
  List<SurveyDataModel> data;

  FullSurveyModel({this.status, this.data});

  FullSurveyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new SurveyDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SurveyDataModel {
  String sId;
  String question;
  String surveyid;
  String type;
  String orgid;
  int iV;
  int choosenAnswer;
  String textFieldAnswer;
  List<Answers> answers;

  SurveyDataModel(
      {this.sId,
      this.question,
      this.surveyid,
      this.type,
      this.choosenAnswer,
      this.textFieldAnswer,
      this.orgid,
      this.iV,
      this.answers});

  SurveyDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    surveyid = json['surveyid'];
    type = json['type'];
    orgid = json['orgid'];
    iV = json['__v'];
    choosenAnswer = null;
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['question'] = this.question;
    data['surveyid'] = this.surveyid;
    data['type'] = this.type;
    data['orgid'] = this.orgid;
    data['__v'] = this.iV;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String sId;
  String qid;
  String title;
  String choice;
  bool selectedAnswer;
  int iV;

  Answers({this.sId, this.qid, this.title, this.choice, this.iV});

  Answers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    qid = json['qid'];
    title = json['title'];
    choice = json['choice'];
    iV = json['__v'];
    selectedAnswer = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['qid'] = this.qid;
    data['title'] = this.title;
    data['choice'] = this.choice;
    data['__v'] = this.iV;
    return data;
  }
}
