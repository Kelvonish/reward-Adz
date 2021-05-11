import 'package:flutter/cupertino.dart';
import 'package:rewardadz/data/models/campaignModel.dart';

import '../../data/models/campaignModel.dart';
import '../../data/services/getCampaignsNetworkService.dart';
import '../Shared/getLocation.dart';

class GetCampaignProvider extends ChangeNotifier {
  CampaignModel campaign = CampaignModel();
  List<CampaignModel> campaignList = [];
  bool loading = false;
  var location;

  Future getCampaignsProvider() async {
    loading = true;
    var _determineLocationClass = DetermineLocation();
    location = await _determineLocationClass.getLocation();
    GetCampaignsClass c = GetCampaignsClass();
    await c.fetchCampaigns(location);
    campaignList = c.campaignList;
    loading = false;
    notifyListeners();
  }
}
