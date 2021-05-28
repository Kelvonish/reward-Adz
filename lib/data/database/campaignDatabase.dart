import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:sqflite/sqflite.dart';

class CampaignDatabase {
  Database db;

  Future open() async {
    var path = await getDatabasesPath();
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table StartedCampaigns ( 
  userId integer primary key, 
  campaignId text not null,
  campaignName text not null,
  campaignMainUrl text not null,
  campaignOrganizationLogo text not null,
  campaignOrganizationIndustry text not null,
  campaignType text not null,
  campaignAmount text not null)
''');
    });
  }

  Future insertCampaign(CampaignModel campaign) async {
    Map values = {
      "userId": "",
      "CampaignId": "",
      "CampaignName": "",
      "CampaignMainUrl": "",
      "CampaignOrganizationLogo": "",
      "CampaignOrganizationIndustry": "",
      "CampaignType": "",
      "CampaignAmount": ""
    };
    await db.insert("StartedCampaigns", values);
  }
}
