import 'package:flutter/cupertino.dart';
import 'package:rewardadz/data/services/getTopAdvertisersNetworkService.dart';
import 'package:rewardadz/data/models/topAdvertisersModel.dart';

class TopAdvertisersProvider extends ChangeNotifier {
  List<TopAdvertisersModel> topAdvertisersList = [];
  getTopAdvertisers() async {
    TopAdvertisersNetworkService c = TopAdvertisersNetworkService();
    await c.getTopAdvertisers();
    topAdvertisersList = c.topAdvertisersList;
  }
}
