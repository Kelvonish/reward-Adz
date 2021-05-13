import 'package:http/http.dart' as http;
import 'package:rewardadz/business_logic/constants/constants.dart';
import 'package:rewardadz/data/models/topAdvertisersModel.dart';
import 'dart:convert';

class TopAdvertisersNetworkService {
  List<TopAdvertisersModel> topAdvertisersList = [];
  Future getTopAdvertisers() async {
    String url = BASE_URL + "campaign/topcampaigns";

    try {
      var uri = Uri.parse(url);
      var response = await http.get(uri);
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
          topAdvertisersList.add(eachElement);
        });
        print(topAdvertisersList);
        return topAdvertisersList;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
