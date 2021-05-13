import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:rewardadz/data/services/getTopAdvertisersNetworkService.dart';
import 'package:rewardadz/data/models/topAdvertisersModel.dart';
import '../Shared/getLocation.dart';
import '../../data/models/campaignModel.dart';

class TopAdvertisersProvider extends ChangeNotifier {
  List<TopAdvertisersModel> topAdvertisersList = [];
  List<CampaignModel> organizationCampaignsList = [];
  bool loading = false;
  bool organizationPageLoading = false;
  var location;
  var _determineLocationClass = DetermineLocation();
  TopAdvertisersNetworkService c = TopAdvertisersNetworkService();
  getTopAdvertisers() async {
    loading = true;

    await c.getTopAdvertisers();
    topAdvertisersList = c.topAdvertisersList;
    loading = false;
    notifyListeners();
  }

  getOrganizationCampaigns(String organizationId) async {
    organizationPageLoading = true;
    if (location == null) {
      location = await _determineLocationClass.getLocation();
    }
    c.organizationCampiagnsList.clear();
    await c.getOrganizationCampaigns(location, organizationId);
    organizationCampaignsList = c.organizationCampiagnsList;
    organizationPageLoading = false;
    notifyListeners();
  }
}
