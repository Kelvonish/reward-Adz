import 'package:flutter/cupertino.dart';
import 'package:rewardadz/data/models/campaignModel.dart';

class GetCampaignProvider extends ChangeNotifier {
  CampaignModel campaign = CampaignModel();
  bool loading = false;

  Future getCampaignsProvider() async {
    loading = true;
    //campaign = await fetchCampaigns();
    loading = false;
    notifyListeners();
    return campaign;
  }
}
