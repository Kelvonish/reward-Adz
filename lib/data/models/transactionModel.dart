class TransactionModel {
  String status;
  List<TransactionData> data;

  TransactionModel({this.status, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new TransactionData.fromJson(v));
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

class TransactionData {
  String naration;
  String txn;
  int userid;
  int amount;
  String createdAt;

  TransactionData(
      {this.naration, this.txn, this.userid, this.amount, this.createdAt});

  TransactionData.fromJson(Map<String, dynamic> json) {
    naration = json['naration'];
    txn = json['txn'];
    userid = json['userid'];
    amount = json['amount'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['naration'] = this.naration;
    data['txn'] = this.txn;
    data['userid'] = this.userid;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
