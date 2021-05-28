import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CampaignDatabase {
  Database db;
  String dbName = "StartedCampaigns";

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

  Future getStartedCampaigns(int userId) async {
    if (db == null) {
      await open();
    }
    var result = db.query(dbName, where: 'userId=?', whereArgs: [107]);
    if (result == null) {
      Fluttertoast.showToast(msg: "Nothing shown");
    }
    print(json.encode(result));
    return result;
  }

  Future<bool> insertCampaign(CampaignModel campaign, int userId) async {
    Map<String, dynamic> values = {
      "userId": userId,
      "campaignId": campaign.sId,
      "campaignName": campaign.name,
      "campaignMainUrl": campaign.campimg,
      "campaignOrganizationLogo": campaign.organization.logo,
      "campaignOrganizationIndustry": campaign.organization.industry,
      "campaignType": "will do",
      "campaignAmount": "50"
    };

    var t = await campaignExists(campaign.sId);
    if (t == null) {
      int d = await db.insert(dbName, values);
      if (d != null) {
        Fluttertoast.showToast(msg: "yeey! saved");
        return true;
      }
    }
    return false;
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
    return await db.delete("dbName", where: 'CampaignId = ?', whereArgs: [id]);
  }
}
