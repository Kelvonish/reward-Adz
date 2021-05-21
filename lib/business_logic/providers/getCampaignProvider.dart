import 'package:flutter/cupertino.dart';
import 'package:rewardadz/data/models/campaignModel.dart';
import 'package:rewardadz/data/models/userModel.dart';

import '../../data/models/campaignModel.dart';
import '../../data/services/getCampaignsNetworkService.dart';
import '../Shared/getLocation.dart';

class GetCampaignProvider extends ChangeNotifier {
  CampaignModel campaign = CampaignModel();
  List<CampaignModel> campaignList = [];
  List<CampaignModel> searchCampaignList = [];
  bool loading = false;
  bool searchLoading = false;
  bool searchPageInitalState = true;
  var location;
  var _determineLocationClass = DetermineLocation();
  GetCampaignsClass campaignClass = GetCampaignsClass();

  Future getCampaignsProvider(UserModel user) async {
    loading = true;
    if (location == null) {
      location = await _determineLocationClass.getLocation();
    }
    await campaignClass.fetchCampaigns(location, user);
    campaignList = campaignClass.campaignList;
    loading = false;
    notifyListeners();
  }

  Future searchCampaigns(String searchQuery) async {
    searchLoading = true;
    searchPageInitalState = false;
    if (location == null) {
      location = await _determineLocationClass.getLocation();
    }
    campaignClass.searchCampaignList.clear();
    await campaignClass.searchCampaigns(location, searchQuery);
    searchCampaignList = campaignClass.searchCampaignList;
    searchLoading = false;
    notifyListeners();
  }
}
