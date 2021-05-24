class FullSurveyModel {
  String status;
  List<Data> data;

  FullSurveyModel({this.status, this.data});

  FullSurveyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  String sId;
  String question;
  String surveyid;
  String type;
  String orgid;
  int iV;
  List<Answers> answers;

  Data(
      {this.sId,
      this.question,
      this.surveyid,
      this.type,
      this.orgid,
      this.iV,
      this.answers});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    surveyid = json['surveyid'];
    type = json['type'];
    orgid = json['orgid'];
    iV = json['__v'];
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
  int iV;

  Answers({this.sId, this.qid, this.title, this.choice, this.iV});

  Answers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    qid = json['qid'];
    title = json['title'];
    choice = json['choice'];
    iV = json['__v'];
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
