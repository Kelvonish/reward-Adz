import 'package:flutter/cupertino.dart';
import 'package:rewardadz/data/services/getTopAdvertisersNetworkService.dart';
import 'package:rewardadz/data/models/topAdvertisersModel.dart';

class TopAdvertisersProvider extends ChangeNotifier {
  List<TopAdvertisersModel> topAdvertisersList = [];
  bool loading = false;
  getTopAdvertisers() async {
    loading = true;
    TopAdvertisersNetworkService c = TopAdvertisersNetworkService();
    await c.getTopAdvertisers();
    topAdvertisersList = c.topAdvertisersList;
    loading = false;
    notifyListeners();
  }
}
