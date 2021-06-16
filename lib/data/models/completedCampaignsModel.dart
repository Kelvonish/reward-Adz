class CompletedCampaignsModel {
  String status;
  List<Data> data;

  CompletedCampaignsModel({this.status, this.data});

  CompletedCampaignsModel.fromJson(Map<String, dynamic> json) {
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
  Campaign campaign;
  Awards awards;

  Data({this.campaign, this.awards});

  Data.fromJson(Map<String, dynamic> json) {
    campaign = json['campaign'] != null
        ? new Campaign.fromJson(json['campaign'])
        : null;
    awards =
        json['awards'] != null ? new Awards.fromJson(json['awards']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.campaign != null) {
      data['campaign'] = this.campaign.toJson();
    }
    if (this.awards != null) {
      data['awards'] = this.awards.toJson();
    }
    return data;
  }
}

class Campaign {
  List<Locations> locations;
  bool isactive;
  String sId;
  String name;
  String type;
  Organization organization;
  String status;
  String campimg;
  String objective;
  int publishedby;
  int iV;
  AudioCompleted audio;
  Banner banner;
  Video video;
  String endage;
  String gender;
  String startage;
  String dailybudget;
  String featured;
  String fromdate;
  String paymentmode;
  String todate;
  String totalbudget;

  Campaign(
      {this.locations,
      this.isactive,
      this.sId,
      this.name,
      this.type,
      this.organization,
      this.status,
      this.campimg,
      this.objective,
      this.publishedby,
      this.iV,
      this.audio,
      this.banner,
      this.video,
      this.endage,
      this.gender,
      this.startage,
      this.dailybudget,
      this.featured,
      this.fromdate,
      this.paymentmode,
      this.todate,
      this.totalbudget});

  Campaign.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      locations = [];
      json['locations'].forEach((v) {
        locations.add(new Locations.fromJson(v));
      });
    }
    isactive = json['isactive'];
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    status = json['status'];
    campimg = json['campimg'];
    objective = json['objective'];
    publishedby = json['publishedby'];
    iV = json['__v'];
    audio = json['audio'];
    banner =
        json['banner'] != null ? new Banner.fromJson(json['banner']) : null;
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
    endage = json['endage'];
    gender = json['gender'];
    startage = json['startage'];
    dailybudget = json['dailybudget'];
    featured = json['featured'];
    fromdate = json['fromdate'];
    paymentmode = json['paymentmode'];
    todate = json['todate'];
    totalbudget = json['totalbudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['locations'] = this.locations.map((v) => v.toJson()).toList();
    }
    data['isactive'] = this.isactive;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.organization != null) {
      data['organization'] = this.organization.toJson();
    }
    data['status'] = this.status;
    data['campimg'] = this.campimg;
    data['objective'] = this.objective;
    data['publishedby'] = this.publishedby;
    data['__v'] = this.iV;
    data['audio'] = this.audio;
    if (this.banner != null) {
      data['banner'] = this.banner.toJson();
    }
    if (this.video != null) {
      data['video'] = this.video.toJson();
    }
    data['endage'] = this.endage;
    data['gender'] = this.gender;
    data['startage'] = this.startage;
    data['dailybudget'] = this.dailybudget;
    data['featured'] = this.featured;
    data['fromdate'] = this.fromdate;
    data['paymentmode'] = this.paymentmode;
    data['todate'] = this.todate;
    data['totalbudget'] = this.totalbudget;
    return data;
  }
}

class Locations {
  double lat;
  double lng;
  int radius;
  String address;
  String id;

  Locations({this.lat, this.lng, this.radius, this.address, this.id});

  Locations.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    radius = json['radius'];
    address = json['address'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['radius'] = this.radius;
    data['address'] = this.address;
    data['id'] = this.id;
    return data;
  }
}

class Organization {
  int id;
  String name;
  String email;
  String industry;
  String phone;
  String logo;
  int userId;
  Null balance;
  String createdAt;
  String updatedAt;

  Organization(
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

  Organization.fromJson(Map<String, dynamic> json) {
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

class Banner {
  String shares;
  String sharesamount;
  Null bannerset;
  Null banneramount;
  String bannerurl;

  Banner(
      {this.shares,
      this.sharesamount,
      this.bannerset,
      this.banneramount,
      this.bannerurl});

  Banner.fromJson(Map<String, dynamic> json) {
    shares = json['shares'];
    sharesamount = json['sharesamount'];
    bannerset = json['bannerset'];
    banneramount = json['banneramount'];
    bannerurl = json['bannerurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shares'] = this.shares;
    data['sharesamount'] = this.sharesamount;
    data['bannerset'] = this.bannerset;
    data['banneramount'] = this.banneramount;
    data['bannerurl'] = this.bannerurl;
    return data;
  }
}

class Video {
  String surveyid;
  String watchedvideosamount;
  String url;

  Video({this.surveyid, this.watchedvideosamount, this.url});

  Video.fromJson(Map<String, dynamic> json) {
    surveyid = json['surveyid'];
    watchedvideosamount = json['watchedvideosamount'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surveyid'] = this.surveyid;
    data['watchedvideosamount'] = this.watchedvideosamount;
    data['url'] = this.url;
    return data;
  }
}

class Awards {
  int id;
  String campid;
  String action;
  Null txn;
  String devicename;
  int uid;
  int status;
  int amount;
  double lat;
  double lng;
  String createdAt;
  String updatedAt;

  Awards(
      {this.id,
      this.campid,
      this.action,
      this.txn,
      this.devicename,
      this.uid,
      this.status,
      this.amount,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt});

  Awards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campid = json['campid'];
    action = json['action'];
    txn = json['txn'];
    devicename = json['devicename'];
    uid = json['uid'];
    status = json['status'];
    amount = json['amount'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['campid'] = this.campid;
    data['action'] = this.action;
    data['txn'] = this.txn;
    data['devicename'] = this.devicename;
    data['uid'] = this.uid;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class AudioCompleted {
  String uniquecalls;
  String award;
  String volume;
  String audiourl;

  AudioCompleted({this.uniquecalls, this.award, this.volume, this.audiourl});

  AudioCompleted.fromJson(Map<String, dynamic> json) {
    uniquecalls = json['uniquecalls'];
    award = json['award'];
    volume = json['volume'];
    audiourl = json['audiourl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniquecalls'] = this.uniquecalls;
    data['award'] = this.award;
    data['volume'] = this.volume;
    data['audiourl'] = this.audiourl;
    return data;
  }
}
