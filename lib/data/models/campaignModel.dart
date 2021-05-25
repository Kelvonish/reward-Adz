class CampaignModel {
  List<LocationsModel> locations;
  bool isactive;
  String sId;
  String name;
  String type;
  OrganizationModel organization;
  String status;
  String campimg;
  String objective;

  int iV;
  AudioModel audio;
  BannerModel banner;
  VideoModel video;
  SurveyModel survey;
  String endage;
  String gender;
  String startage;
  String dailybudget;
  String featured;
  String fromdate;
  String paymentmode;
  String todate;
  String totalbudget;

  CampaignModel(
      {this.locations,
      this.isactive,
      this.sId,
      this.name,
      this.type,
      this.organization,
      this.status,
      this.campimg,
      this.objective,
      this.iV,
      this.audio,
      this.banner,
      this.video,
      this.survey,
      this.endage,
      this.gender,
      this.startage,
      this.dailybudget,
      this.featured,
      this.fromdate,
      this.paymentmode,
      this.todate,
      this.totalbudget});

  CampaignModel.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      locations = [];
      json['locations'].forEach((v) {
        locations.add(new LocationsModel.fromJson(v));
      });
    }
    isactive = json['isactive'];
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    organization = json['organization'] != null
        ? new OrganizationModel.fromJson(json['organization'])
        : null;
    status = json['status'];
    campimg = json['campimg'];
    objective = json['objective'];
    iV = json['__v'];
    audio = json['audio'];
    banner = json['banner'];
    video =
        json['video'] != null ? new VideoModel.fromJson(json['video']) : null;
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
    data['__v'] = this.iV;
    data['audio'] = this.audio;
    data['banner'] = this.banner;
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

class LocationsModel {
  double lat;
  double lng;
  int radius;
  String address;
  String id;

  LocationsModel({this.lat, this.lng, this.radius, this.address, this.id});

  LocationsModel.fromJson(Map<String, dynamic> json) {
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

class OrganizationModel {
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

  OrganizationModel(
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

  OrganizationModel.fromJson(Map<String, dynamic> json) {
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

class VideoModel {
  String surveyid;
  String watchedvideosamount;
  String url;

  VideoModel({this.surveyid, this.watchedvideosamount, this.url});

  VideoModel.fromJson(Map<String, dynamic> json) {
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

class AudioModel {
  String uniquecalls;
  String award;
  String volume;
  String audiourl;

  AudioModel({this.uniquecalls, this.award, this.volume, this.audiourl});

  AudioModel.fromJson(Map<String, dynamic> json) {
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

class SurveyModel {
  String surveyid;
  String amount;

  SurveyModel({this.surveyid, this.amount});

  SurveyModel.fromJson(Map<String, dynamic> json) {
    surveyid = json['surveyid'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surveyid'] = this.surveyid;
    data['amount'] = this.amount;
    return data;
  }
}

class BannerModel {
  String shares;
  String sharesamount;
  Null bannerset;
  Null banneramount;
  String bannerurl;

  BannerModel(
      {this.shares,
      this.sharesamount,
      this.bannerset,
      this.banneramount,
      this.bannerurl});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
