import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/business_logic/providers/checkInternetProvider.dart';
import 'package:rewardadz/data/local storage/locationPreference.dart';
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
  TopAdvertisersNetworkService c = TopAdvertisersNetworkService();
  bool isInternetConnected;
  checkInternetConnection() async {
    isInternetConnected = await ConnectivityService().checkInternetConnection();
    notifyListeners();
  }

  getTopAdvertisers() async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      loading = true;

      await c.getTopAdvertisers();
      topAdvertisersList = c.topAdvertisersList;
      loading = false;
      notifyListeners();
    }
  }

  getOrganizationCampaigns(String organizationId) async {
    await checkInternetConnection();
    if (isInternetConnected == false) {
      Fluttertoast.showToast(msg: "No internet connection");
    } else {
      organizationPageLoading = true;
      if (location == null) {
        location = await LocationPreference().getLocation();
        if (location == null) {
          await LocationPreference().saveLocation();
          location = await LocationPreference().getLocation();
        }
      }
      c.organizationCampiagnsList.clear();
      await c.getOrganizationCampaigns(location, organizationId);
      organizationCampaignsList = c.organizationCampiagnsList;
      organizationPageLoading = false;
      notifyListeners();
    }
  }
}
