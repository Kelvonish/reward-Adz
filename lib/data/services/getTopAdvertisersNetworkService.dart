import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/data/models/topAdvertisersModel.dart';
import 'dart:convert';

class TopAdvertisersNetworkService {
  List<TopAdvertisersModel> topAdvertisersList = [];
  List<CampaignModel> organizationCampiagnsList = [];

  Future getTopAdvertisers(String token) async {
    print(token);
    String url = BASE_URL + "campaign/topcampaigns";

    try {
      var uri = Uri.parse(url);
      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token,
      });
      if (response.statusCode == 200) {
        var returnedData = jsonDecode(response.body);
        returnedData['data'].forEach((json) {
          TopAdvertisersModel eachElement = TopAdvertisersModel(
              id: json['id'],
              name: json['name'],
              email: json['email'],
              industry: json['industry'],
              phone: json['phone'],
              logo: json['logo'],
              userId: json['user_id'],
              balance: json['balance'],
              createdAt: json['createdAt'],
              updatedAt: json['updatedAt']);
          var contain = topAdvertisersList
              .where((element) => element.id == eachElement.id);
          if (contain.isEmpty) {
            topAdvertisersList.add(eachElement);
          }
        });

        return topAdvertisersList;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getOrganizationCampaigns(
      var location, String organizationId, String token) async {
    try {
      String url = BASE_URL +
          "organization/org/latitude/" +
          location[0] +
          "/longitude/" +
          location[1] +
          "/" +
          organizationId +
          "/page/1/limit/20";
      var parsedUrl = Uri.parse(url);

      var response = await http.get(parsedUrl, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token,
      });

      if (response.statusCode == 200) {
        var campaigns = jsonDecode(response.body);
        if (Platform.isIOS) {
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
                audio: null,
                video: json['video'] != null
                    ? VideoModel(
                        surveyid: json['video']['surveyid'],
                        watchedvideosamount: json['video']
                            ['watchedvideosamount'],
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

              var contain = organizationCampiagnsList
                  .where((element) => element.sId == newData.sId);

              if (contain.isEmpty) {
                organizationCampiagnsList.add(newData);
              }
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
                audio: null,
                video: json['video'] != null
                    ? VideoModel(
                        surveyid: json['video']['surveyid'],
                        watchedvideosamount: json['video']
                            ['watchedvideosamount'],
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
              var contain = organizationCampiagnsList
                  .where((element) => element.sId == newData.sId);

              if (contain.isEmpty) {
                organizationCampiagnsList.add(newData);
              }
            }
          });
        } else {
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
                        watchedvideosamount: json['video']
                            ['watchedvideosamount'],
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

              var contain = organizationCampiagnsList
                  .where((element) => element.sId == newData.sId);

              if (contain.isEmpty) {
                organizationCampiagnsList.add(newData);
              }
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
                        watchedvideosamount: json['video']
                            ['watchedvideosamount'],
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
              var contain = organizationCampiagnsList
                  .where((element) => element.sId == newData.sId);

              if (contain.isEmpty) {
                organizationCampiagnsList.add(newData);
              }
            }
          });
        }

        return organizationCampiagnsList;
      } else {
        print("No data found");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
