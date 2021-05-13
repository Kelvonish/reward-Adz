import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/campaignModel.dart';

//import 'package:fluttertoast/fluttertoast.dart';
class GetCampaignsClass {
  List<CampaignModel> campaignList = [];

  Future fetchCampaigns(LocationData location) async {
    try {
      String url = BASE_URL +
          "campaign/list/page/1/limit/75?gender=Male&lat=" +
          location.latitude.toString() +
          "&lng=" +
          location.longitude.toString();
      print("Url:     " + url);
      var parsedUrl = Uri.parse(url);
      var response = await http.get(parsedUrl);

      if (response.statusCode == 200) {
        var campaigns = jsonDecode(response.body);

        campaigns['data'].forEach((json) {
          if (json.containsKey("survey")) {
            CampaignModel newData = CampaignModel(
              isactive: json['isactive'],
              sId: json['_id'],
              name: json['name'],
              type: json['type'],
              organization: json['organization'] != null
                  ? OrganizationModel(
                      id: json['organization']['id'],
                      name: json['organization']['name'],
                      email: json['organization']['email'],
                      industry: json['organization']['industry'],
                      phone: json['organization']['phone'],
                      logo: json['organization']['logo'],
                      userId: json['organization']['user_id'],
                      balance: json['organization']['balance'],
                      createdAt: json['organization']['createdAt'],
                      updatedAt: json['organization']['updatedAt'],
                    )
                  : null,
              status: json['status'],
              campimg: json['campimg'],
              objective: json['objective'],
              iV: json['__v'],
              audio: json['audio'] != null
                  ? AudioModel(
                      uniquecalls: json['audio']['uniquecalls'],
                      award: json['audio']['award'],
                      volume: json['audio']['volume'],
                      audiourl: json['audio']['audiourl'])
                  : null,
              video: json['video'] != null
                  ? VideoModel(
                      surveyid: json['video']['surveyid'],
                      watchedvideosamount: json['video']['watchedvideosamount'],
                      url: json['video']['url'])
                  : null,
              survey: json['survey'] != null
                  ? SurveyModel(
                      amount: json['survey']['amount'],
                      surveyid: json['survey']['surveyid'])
                  : null,
              endage: json['endage'],
              gender: json['gender'],
              startage: json['startage'],
              dailybudget: json['dailybudget'],
              featured: json['featured'],
              fromdate: json['fromdate'],
              paymentmode: json['paymentmode'],
              todate: json['todate'],
              totalbudget: json['totalbudget'],
            );
            campaignList.add(newData);
          } else {
            CampaignModel newData = CampaignModel(
              isactive: json['isactive'],
              sId: json['_id'],
              name: json['name'],
              type: json['type'],
              organization: json['organization'] != null
                  ? OrganizationModel(
                      id: json['organization']['id'],
                      name: json['organization']['name'],
                      email: json['organization']['email'],
                      industry: json['organization']['industry'],
                      phone: json['organization']['phone'],
                      logo: json['organization']['logo'],
                      userId: json['organization']['user_id'],
                      balance: json['organization']['balance'],
                      createdAt: json['organization']['createdAt'],
                      updatedAt: json['organization']['updatedAt'],
                    )
                  : null,
              status: json['status'],
              campimg: json['campimg'],
              objective: json['objective'],
              iV: json['__v'],
              audio: json['audio'] != null
                  ? AudioModel(
                      uniquecalls: json['audio']['uniquecalls'],
                      award: json['audio']['award'],
                      volume: json['audio']['volume'],
                      audiourl: json['audio']['audiourl'])
                  : null,
              video: json['video'] != null
                  ? VideoModel(
                      surveyid: json['video']['surveyid'],
                      watchedvideosamount: json['video']['watchedvideosamount'],
                      url: json['video']['url'])
                  : null,
              survey: null,
              endage: json['endage'],
              gender: json['gender'],
              startage: json['startage'],
              dailybudget: json['dailybudget'],
              featured: json['featured'],
              fromdate: json['fromdate'],
              paymentmode: json['paymentmode'],
              todate: json['todate'],
              totalbudget: json['totalbudget'],
            );
            campaignList.add(newData);
          }
        });

        return campaignList;
      } else {
        print("No data found");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future searchCampaigns(
    LocationData location,
    String query,
  ) async {
    try {
      String url = BASE_URL +
          "campaign/list/page/1/limit/75?gender=Male&lat=-1.2546569&lng=36.7976165";
      var parsedUrl = Uri.parse(url);
      var response = await http.get(parsedUrl);

      if (response.statusCode == 200) {
        var campaigns = jsonDecode(response.body);

        campaigns['data'].forEach((json) {
          if (json.containsKey("survey")) {
            CampaignModel newData = CampaignModel(
              isactive: json['isactive'],
              sId: json['_id'],
              name: json['name'],
              type: json['type'],
              organization: json['organization'] != null
                  ? OrganizationModel(
                      id: json['organization']['id'],
                      name: json['organization']['name'],
                      email: json['organization']['email'],
                      industry: json['organization']['industry'],
                      phone: json['organization']['phone'],
                      logo: json['organization']['logo'],
                      userId: json['organization']['user_id'],
                      balance: json['organization']['balance'],
                      createdAt: json['organization']['createdAt'],
                      updatedAt: json['organization']['updatedAt'],
                    )
                  : null,
              status: json['status'],
              campimg: json['campimg'],
              objective: json['objective'],
              iV: json['__v'],
              audio: json['audio'] != null
                  ? AudioModel(
                      uniquecalls: json['audio']['uniquecalls'],
                      award: json['audio']['award'],
                      volume: json['audio']['volume'],
                      audiourl: json['audio']['audiourl'])
                  : null,
              video: json['video'] != null
                  ? VideoModel(
                      surveyid: json['video']['surveyid'],
                      watchedvideosamount: json['video']['watchedvideosamount'],
                      url: json['video']['url'])
                  : null,
              survey: json['survey'] != null
                  ? SurveyModel(
                      amount: json['survey']['amount'],
                      surveyid: json['survey']['surveyid'])
                  : null,
              endage: json['endage'],
              gender: json['gender'],
              startage: json['startage'],
              dailybudget: json['dailybudget'],
              featured: json['featured'],
              fromdate: json['fromdate'],
              paymentmode: json['paymentmode'],
              todate: json['todate'],
              totalbudget: json['totalbudget'],
            );
            campaignList.add(newData);
          } else {
            CampaignModel newData = CampaignModel(
              isactive: json['isactive'],
              sId: json['_id'],
              name: json['name'],
              type: json['type'],
              organization: json['organization'] != null
                  ? OrganizationModel(
                      id: json['organization']['id'],
                      name: json['organization']['name'],
                      email: json['organization']['email'],
                      industry: json['organization']['industry'],
                      phone: json['organization']['phone'],
                      logo: json['organization']['logo'],
                      userId: json['organization']['user_id'],
                      balance: json['organization']['balance'],
                      createdAt: json['organization']['createdAt'],
                      updatedAt: json['organization']['updatedAt'],
                    )
                  : null,
              status: json['status'],
              campimg: json['campimg'],
              objective: json['objective'],
              iV: json['__v'],
              audio: json['audio'] != null
                  ? AudioModel(
                      uniquecalls: json['audio']['uniquecalls'],
                      award: json['audio']['award'],
                      volume: json['audio']['volume'],
                      audiourl: json['audio']['audiourl'])
                  : null,
              video: json['video'] != null
                  ? VideoModel(
                      surveyid: json['video']['surveyid'],
                      watchedvideosamount: json['video']['watchedvideosamount'],
                      url: json['video']['url'])
                  : null,
              survey: null,
              endage: json['endage'],
              gender: json['gender'],
              startage: json['startage'],
              dailybudget: json['dailybudget'],
              featured: json['featured'],
              fromdate: json['fromdate'],
              paymentmode: json['paymentmode'],
              todate: json['todate'],
              totalbudget: json['totalbudget'],
            );
            campaignList.add(newData);
          }
        });

        return campaignList;
      } else {
        print("No data found");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
