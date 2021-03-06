
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/providers/checkInternetProvider.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/data/models/userModel.dart';
import 'package:rewardadz/data/models/surveyModel.dart';
import 'package:rewardadz/presentation/screens/survey/surveyPage.dart';
import 'package:rewardadz/data/local storage/locationPreference.dart';
import '../../data/models/campaignModel.dart';
import '../../data/models/completedCampaignsModel.dart';
import '../../data/services/getCampaignsNetworkService.dart';

class GetCampaignProvider extends ChangeNotifier {
  CampaignModel campaign = CampaignModel();
  List<CampaignModel> campaignList = [];
  List<CampaignModel> searchCampaignList = [];
  bool loading = false;
  bool searchLoading = false;
  bool searchPageInitalState = true;
  bool loadingSurvey = false;
  bool loadingCompletedCampaigns = false;
  var location;
  bool isInternetConnected = true;
  bool loadingCampaignDetails = false;
  FullSurveyModel videoSurvey;
  CampaignModel linkCampaignDetails;
  CompletedCampaignsModel completedCampaigns;

  GetCampaignsClass campaignClass = GetCampaignsClass();

  checkInternetConnection() async {
    isInternetConnected = await ConnectivityService().checkInternetConnection();
    notifyListeners();
  }

  Future getCampaigns(UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loading = true;
      notifyListeners();
      if (location == null) {
        location = await LocationPreference().getLocation();
        if (location == null) {
          await LocationPreference().saveLocation();
          location = await LocationPreference().getLocation();
        }
      }
      await campaignClass.fetchCampaigns(location, user);
      campaignList = campaignClass.campaignList;
      loading = false;
      notifyListeners();
    }
  }

  Future refreshCampaigns(UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      if (campaignList.isEmpty) {
        loading = true;
        notifyListeners();
      }
      if (location == null) {
        location = await LocationPreference().getLocation();
        if (location == null) {
          await LocationPreference().saveLocation();
          location = await LocationPreference().getLocation();
        }
      }
      await campaignClass.fetchCampaigns(location, user);
      campaignList = [];
      campaignList = campaignClass.campaignList;
      loading = false;
      notifyListeners();
    }
  }

  Future searchCampaigns(String searchQuery, String token) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      searchLoading = true;
      searchPageInitalState = false;
      if (location == null) {
        location = await LocationPreference().getLocation();
        if (location == null) {
          await LocationPreference().saveLocation();
          location = await LocationPreference().getLocation();
        }
      }
      campaignClass.searchCampaignList.clear();
      await campaignClass.searchCampaigns(location, searchQuery, token);
      searchCampaignList = campaignClass.searchCampaignList;
      searchLoading = false;
      notifyListeners();
    }
  }

  Future getSurvey(BuildContext context, String surveyId, String campaignName,
      String token) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loadingSurvey = true;
      notifyListeners();
      FullSurveyModel returnedSurvey =
          await campaignClass.getSurvey(surveyId, token);
      if (returnedSurvey != null) {
        loadingSurvey = false;
        notifyListeners();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Survey(
                      surveyModel: returnedSurvey,
                      pageTitle: campaignName,
                    )));
      }
      loadingSurvey = false;
      notifyListeners();
    }
  }

  Future getCompletedCampaigns(UserModel user) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loadingCompletedCampaigns = true;
      notifyListeners();
      CompletedCampaignsModel returnedData =
          await campaignClass.getCompletedCampaigns(user);
      completedCampaigns = returnedData;
      loadingCompletedCampaigns = false;
      notifyListeners();
    }
  }

  Future getVideoSurvey(String surveyId, String token) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loadingSurvey = true;

      FullSurveyModel returnedSurvey =
          await campaignClass.getSurvey(surveyId, token);
      if (returnedSurvey != null) {
        videoSurvey = returnedSurvey;
      }
      loadingSurvey = false;
      notifyListeners();
    }
  }

  Future getSingleCampaign(String id, String token) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loadingCampaignDetails = true;
      notifyListeners();
      CampaignModel returnedCampaign =
          await campaignClass.getSingleCampaign(id, token);
      if (returnedCampaign != null) {
        linkCampaignDetails = returnedCampaign;
      }
      loadingCampaignDetails = false;
      notifyListeners();
    }
  }
}
