class TopAdvertisersModel {
  int id;
  String name;
  String email;
  String industry;
  String phone;
  String logo;
  int userId;
  int balance;
  String createdAt;
  String updatedAt;

  TopAdvertisersModel(
      {this.id,
      this.name,
      this.email,
      this.industry,
      this.phone,
      this.logo,
      this.userId,
      this.balance,
      this.createdAt,
      this.updatedAt});

  TopAdvertisersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    industry = json['industry'];
    phone = json['phone'];
    logo = json['logo'];
    userId = json['user_id'];
    balance = json['balance'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['industry'] = this.industry;
    data['phone'] = this.phone;
    data['logo'] = this.logo;
    data['user_id'] = this.userId;
    data['balance'] = this.balance;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
