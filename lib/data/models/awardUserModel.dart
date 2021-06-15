class AwardUserModel {
  String amount;
  String campid;
  String uid;
  String action;
  int status;
  double lat;
  double lng;
  String devicename;

  AwardUserModel(
      {this.amount,
      this.campid,
      this.uid,
      this.action,
      this.status,
      this.lat,
      this.lng,
      this.devicename});

  AwardUserModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    campid = json['campid'];
    uid = json['uid'];
    action = json['action'];
    status = json['status'];
    lat = json['lat'];
    lng = json['lng'];
    devicename = json['devicename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['campid'] = this.campid;
    data['uid'] = this.uid;
    data['action'] = this.action;
    data['status'] = this.status;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['devicename'] = this.devicename;
    return data;
  }
}

class AwardNotificationModel {
  String description;
  String title;

  AwardNotificationModel({this.description, this.title});

  AwardNotificationModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}
