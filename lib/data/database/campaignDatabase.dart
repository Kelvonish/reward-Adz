import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CampaignDatabaseProvider extends ChangeNotifier {
  Database db;
  Database dbCompleted;
  String dbName = "StartedCampaigns";
  String completedDbName = "CompletedCampaigns";

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'campaigns.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table $dbName ( 
  userId integer , 
  campaignId text primary key,
  campaignName text not null,
  campaignMainUrl text not null,
  campaignOrganizationLogo text not null,
  campaignOrganizationIndustry text not null,
  campaignType text not null,
  campaignAmount text not null)
''');
    });
  }

  Future openCompletedDatabase() async {
    dbCompleted = await openDatabase(
        join(await getDatabasesPath(), 'completedCampaigns.db'),
        version: 1, onCreate: (Database dbCompleted, int version) async {
      await dbCompleted.execute('''
create table $completedDbName ( 
  userId integer , 
  campaignId text primary key,
  campaignName text not null,
  campaignMainUrl text not null,
  campaignOrganizationLogo text not null,
  campaignOrganizationIndustry text not null,
  campaignType text not null,
  campaignAmount text not null)
''');
    });
  }

  Future<List<Map<String, Object>>> getStartedCampaigns(int userId) async {
    if (db == null) {
      await open();
    }
    var result = db.query(dbName, where: 'userId=?', whereArgs: [userId]);
    if (result == null) {
      Fluttertoast.showToast(msg: "Nothing shown");
    }

    return result;
  }

  Future<List<Map<String, Object>>> getCompletedCampaigns(int userId) async {
    if (dbCompleted == null) {
      await openCompletedDatabase();
    }
    var result = dbCompleted
        .query(completedDbName, where: 'userId=?', whereArgs: [userId]);
    if (result == null) {
      Fluttertoast.showToast(msg: "Nothing shown");
    }

    return result;
  }

  String checkType(CampaignModel campaign) {
    if (campaign.audio != null) {
      return "Audio";
    } else if (campaign.video != null) {
      return "Video";
    } else if (campaign.survey != null) {
      return "Survey";
    } else if (campaign.banner != null) {
      return "Banner";
    }
    return "Unknown";
  }

  String checkAmount(CampaignModel campaign) {
    if (campaign.audio != null) {
      return campaign.audio.award;
    } else if (campaign.video != null) {
      return campaign.video.watchedvideosamount;
    } else if (campaign.survey != null) {
      return campaign.survey.amount;
    } else if (campaign.banner != null) {
      return campaign.banner.sharesamount;
    }
    return "Unknown";
  }

  Future<bool> insertCampaign(CampaignModel campaign, int userId) async {
    Map<String, dynamic> values = {
      "userId": userId,
      "campaignId": campaign.sId,
      "campaignName": campaign.name,
      "campaignMainUrl": campaign.campimg,
      "campaignOrganizationLogo": campaign.organization.logo,
      "campaignOrganizationIndustry": campaign.organization.industry,
      "campaignType": checkType(campaign),
      "campaignAmount": checkAmount(campaign),
    };

    var t = await campaignExists(campaign.sId);

    if (t.isEmpty) {
      await db.insert(dbName, values);
    } else {}
    notifyListeners();
    return false;
  }

  Future<bool> insertCompletedCampaign(
      CampaignModel campaign, int userId) async {
    Map<String, dynamic> values = {
      "userId": userId,
      "campaignId": campaign.sId,
      "campaignName": campaign.name,
      "campaignMainUrl": campaign.campimg,
      "campaignOrganizationLogo": campaign.organization.logo,
      "campaignOrganizationIndustry": campaign.organization.industry,
      "campaignType": checkType(campaign),
      "campaignAmount": checkAmount(campaign),
    };

    var t = await completedCampaignExists(campaign.sId);

    if (t.isEmpty) {
      await dbCompleted.insert(completedDbName, values);
    } else {}
    notifyListeners();
    return false;
  }

  Future completedCampaignExists(String campaignId) async {
    if (dbCompleted == null) {
      await openCompletedDatabase();
    }
    return dbCompleted
        .query(completedDbName, where: 'CampaignId=?', whereArgs: [campaignId]);
  }

  Future campaignExists(String campaignId) async {
    if (db == null) {
      await open();
    }
    return db.query(dbName, where: 'CampaignId=?', whereArgs: [campaignId]);
  }

  Future<int> delete(String id) async {
    if (db == null) {
      await open();
    }
    int t = await db.delete(dbName, where: 'CampaignId = ?', whereArgs: [id]);
    if (t == null) {
      Fluttertoast.showToast(msg: "Not Deleted");
    } else {
      Fluttertoast.showToast(msg: "deleted");
    }
    notifyListeners();
    return t;
  }
}
