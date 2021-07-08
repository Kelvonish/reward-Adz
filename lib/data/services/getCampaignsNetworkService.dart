import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/data/models/surveyModel.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/data/models/completedCampaignsModel.dart';

import '../models/campaignModel.dart';

//import 'package:fluttertoast/fluttertoast.dart';
class GetCampaignsClass {
  List<CampaignModel> campaignList = [];
  List<CampaignModel> searchCampaignList = [];

  Future fetchCampaigns(var location, UserModel user) async {
    print(user.data.id);
    try {
      String url = BASE_URL +
          "campaign/list/page/1/limit/75?gender=" +
          user.data.gender +
          "&lat=" +
          location[0] +
          "&lng=" +
          location[1];

      var parsedUrl = Uri.parse(url);
      var response = await http.get(parsedUrl, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': user.token,
      });

      if (response.statusCode == 200) {
        var campaigns = jsonDecode(response.body);
        campaignList = [];
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
                banner: json['banner'] != null
                    ? BannerModel(
                        shares: json['banner']['shares'],
                        sharesamount: json['banner']['sharesamount'],
                        bannerset: json['banner']['bannerset'],
                        banneramount: json['banner']['banneramount'],
                        bannerurl: json['banner']['bannerurl'],
                      )
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
              var contain =
                  campaignList.where((element) => element.sId == newData.sId);

              if (contain.isEmpty) {
                campaignList.add(newData);
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
                banner: json['banner'] != null
                    ? BannerModel(
                        shares: json['banner']['shares'],
                        sharesamount: json['banner']['sharesamount'],
                        bannerset: json['banner']['bannerset'],
                        banneramount: json['banner']['banneramount'],
                        bannerurl: json['banner']['bannerurl'],
                      )
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
              var contain =
                  campaignList.where((element) => element.sId == newData.sId);
              print(contain);
              if (contain.isEmpty) {
                campaignList.add(newData);
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
                banner: json['banner'] != null
                    ? BannerModel(
                        shares: json['banner']['shares'],
                        sharesamount: json['banner']['sharesamount'],
                        bannerset: json['banner']['bannerset'],
                        banneramount: json['banner']['banneramount'],
                        bannerurl: json['banner']['bannerurl'],
                      )
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
              var contain =
                  campaignList.where((element) => element.sId == newData.sId);

              if (contain.isEmpty) {
                campaignList.add(newData);
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
                banner: json['banner'] != null
                    ? BannerModel(
                        shares: json['banner']['shares'],
                        sharesamount: json['banner']['sharesamount'],
                        bannerset: json['banner']['bannerset'],
                        banneramount: json['banner']['banneramount'],
                        bannerurl: json['banner']['bannerurl'],
                      )
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
              var contain =
                  campaignList.where((element) => element.sId == newData.sId);
              print(contain);
              if (contain.isEmpty) {
                campaignList.add(newData);
              }
            }
          });
        }

        return campaignList;
      } else {
        print("No data found");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future searchCampaigns(var location, String query, String token) async {
    try {
      String url = BASE_URL +
          "campaign/search/latitude/" +
          location[0] +
          "/longitude/" +
          location[1] +
          "/page/1/limit/10";
      var parsedUrl = Uri.parse(
        url,
      );
      Map data = {'name': query};
      //encode Map to JSON
      var body = json.encode(data);
      var response = await http.post(parsedUrl,
          headers: {
            "Content-Type": "application/json",
            'x-access-token': token
          },
          body: body);

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
                banner: json['banner'] != null
                    ? BannerModel(
                        shares: json['shares'],
                        sharesamount: json['sharesamount'],
                        bannerset: json['bannerset'],
                        banneramount: json['banneramount'],
                        bannerurl: json['bannerurl'],
                      )
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

              var contain = searchCampaignList
                  .where((element) => element.sId == newData.sId);
              if (contain.isEmpty) {
                searchCampaignList.add(newData);
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
                banner: json['banner'] != null
                    ? BannerModel(
                        shares: json['shares'],
                        sharesamount: json['sharesamount'],
                        bannerset: json['bannerset'],
                        banneramount: json['banneramount'],
                        bannerurl: json['bannerurl'],
                      )
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
              var contain = searchCampaignList
                  .where((element) => element.sId == newData.sId);
              if (contain.isEmpty) {
                searchCampaignList.add(newData);
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
                banner: json['banner'] != null
                    ? BannerModel(
                        shares: json['shares'],
                        sharesamount: json['sharesamount'],
                        bannerset: json['bannerset'],
                        banneramount: json['banneramount'],
                        bannerurl: json['bannerurl'],
                      )
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

              var contain = searchCampaignList
                  .where((element) => element.sId == newData.sId);
              if (contain.isEmpty) {
                searchCampaignList.add(newData);
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
                banner: json['banner'] != null
                    ? BannerModel(
                        shares: json['shares'],
                        sharesamount: json['sharesamount'],
                        bannerset: json['bannerset'],
                        banneramount: json['banneramount'],
                        bannerurl: json['bannerurl'],
                      )
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
              var contain = searchCampaignList
                  .where((element) => element.sId == newData.sId);
              if (contain.isEmpty) {
                searchCampaignList.add(newData);
              }
            }
          });
        }

        return searchCampaignList;
      } else {
        print("No data found");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getSurvey(String surveyId, String token) async {
    try {
      String uri = BASE_URL + "mysurvey/$surveyId";
      var url = Uri.parse(uri);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token,
      });
      var returnedData = json.decode(response.body);

      if (response.statusCode == 200) {
        return FullSurveyModel.fromJson(returnedData);
      } else {
        Fluttertoast.showToast(msg: "Error getting survey");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  getCompletedCampaigns(UserModel user) async {
    try {
      String uri = BASE_URL +
          "viewedads/" +
          user.data.id.toString() +
          "/page/1/limit/75";
      var url = Uri.parse(uri);

      var response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': user.token,
      });
      var returnedData = json.decode(response.body);

      if (response.statusCode == 200) {
        return CompletedCampaignsModel.fromJson(returnedData);
      } else {
        Fluttertoast.showToast(msg: "Error getting completed campaigns");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<CampaignModel> getSingleCampaign(String id, String token) async {
    try {
      String uri = BASE_URL + "campaign/id/$id";
      var url = Uri.parse(uri);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': token,
      });
      var returnedData = json.decode(response.body);
      if (response.statusCode == 200) {
        CampaignModel data = CampaignModel(
          isactive: returnedData['data']['isactive'],
          sId: returnedData['data']['_id'],
          name: returnedData['data']['name'],
          type: returnedData['data']['type'],
          organization: returnedData['data']['organization'] != null
              ? OrganizationModel(
                  id: returnedData['data']['organization']['id'],
                  name: returnedData['data']['organization']['name'],
                  email: returnedData['data']['organization']['email'],
                  industry: returnedData['data']['organization']['industry'],
                  phone: returnedData['data']['organization']['phone'],
                  logo: returnedData['data']['organization']['logo'],
                  userId: returnedData['data']['organization']['user_id'],
                  balance: returnedData['data']['organization']['balance'],
                  createdAt: returnedData['data']['organization']['createdAt'],
                  updatedAt: returnedData['data']['organization']['updatedAt'],
                )
              : null,
          status: returnedData['status'],
          campimg: returnedData['data']['campimg'],
          objective: returnedData['data']['objective'],
          iV: returnedData['data']['__v'],
          audio: returnedData['data']['audio'] != null
              ? AudioModel(
                  uniquecalls: returnedData['data']['audio']['uniquecalls'],
                  award: returnedData['data']['audio']['award'],
                  volume: returnedData['data']['audio']['volume'],
                  audiourl: returnedData['data']['audio']['audiourl'])
              : null,
          banner: returnedData['data']['banner'] != null
              ? BannerModel(
                  shares: returnedData['data']['banner']['shares'],
                  sharesamount: returnedData['data']['banner']['sharesamount'],
                  bannerset: returnedData['data']['banner']['bannerset'],
                  banneramount: returnedData['data']['banner']['banneramount'],
                  bannerurl: returnedData['data']['banner']['bannerurl'],
                )
              : null,
          video: returnedData['video'] != null
              ? VideoModel(
                  surveyid: returnedData['data']['video']['surveyid'],
                  watchedvideosamount: returnedData['data']['video']
                      ['watchedvideosamount'],
                  url: returnedData['data']['video']['url'])
              : null,
          survey: returnedData['data']['survey'] != null
              ? SurveyModel(
                  amount: returnedData['data']['survey']['amount'],
                  surveyid: returnedData['data']['survey']['surveyid'])
              : null,
          endage: returnedData['data']['endage'],
          gender: returnedData['data']['gender'],
          startage: returnedData['data']['startage'],
          dailybudget: returnedData['data']['dailybudget'],
          featured: returnedData['data']['featured'],
          fromdate: returnedData['data']['fromdate'],
          paymentmode: returnedData['data']['paymentmode'],
          todate: returnedData['data']['todate'],
          totalbudget: returnedData['data']['totalbudget'],
        );
        return data;
      } else {
        Fluttertoast.showToast(msg: "Error getting single campaign");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
