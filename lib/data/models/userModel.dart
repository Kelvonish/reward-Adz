class UserModel {
  String status;
  DataModel data;
  String token;
  String refreshToken;
  int balance;
  int totalreward;
  int earnedads;

  UserModel(
      {this.status,
      this.data,
      this.token,
      this.refreshToken,
      this.balance,
      this.earnedads,
      this.totalreward});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DataModel.fromJson(json['data']) : null;
    token = json['token'];
    refreshToken = json['refreshToken'];
    balance = json['balance'];
    totalreward = json['totalreward'];
    earnedads = json['earnedads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['balance'] = this.balance;
    data['totalreward'] = this.totalreward;
    data['earnedads'] = this.earnedads;
    return data;
  }
}

class DataModel {
  int id;
  String lname;
  String fname;
  String email;
  String password;
  String gender;
  String dob;
  String phone;
  Null terms;
  Null image;
  String currency;
  int status;
  String country;
  Null randid;
  String type;
  String createdAt;
  String updatedAt;

  DataModel(
      {this.id,
      this.lname,
      this.fname,
      this.email,
      this.password,
      this.gender,
      this.dob,
      this.phone,
      this.terms,
      this.image,
      this.currency,
      this.status,
      this.country,
      this.randid,
      this.type,
      this.createdAt,
      this.updatedAt});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lname = json['lname'];
    fname = json['fname'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    dob = json['dob'];
    phone = json['phone'];
    terms = json['terms'];
    image = json['image'];
    currency = json['currency'];
    status = json['status'];
    country = json['country'];
    randid = json['randid'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lname'] = this.lname;
    data['fname'] = this.fname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['phone'] = this.phone;
    data['terms'] = this.terms;
    data['image'] = this.image;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['country'] = this.country;
    data['randid'] = this.randid;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
