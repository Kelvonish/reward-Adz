import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:rewardadz/data/models/campaignModel.dart';

//import 'package:fluttertoast/fluttertoast.dart';
class GetCampaignsClass {
  List<CampaignModel> campaignList = [];

  Future fetchCampaigns(LocationData location) async {
    try {
      String url =
          "https://api.themoviedb.org/3/movie/popular?api_key=a5ce1e09b056552ca4d30c679d69e75b&language=en-US&page=1";
      var parsedUrl = Uri.parse(url);
      var response = await http.post(parsedUrl);

      if (response.statusCode == 200) {
        var campaigns = jsonDecode(response.body);
        campaigns['results'].forEach((element) {
          CampaignModel newData = CampaignModel(
              adult: element['adult'],
              backdropPath: element['backdrop_path'],
              originalLanguage: element['original_language'],
              originalTitle: element['original_title'],
              overview: element['overview'],
              posterPath: element['poster_path'],
              releaseDate: element['release_date'],
              title: element['title'],
              video: element['video'],
              voteCount: element['vote_count']);
          campaignList.add(newData);
        });
        // result = CampaignModel.fromJson(campaigns['results']);
        return campaignList;
      } else {
        print("No data found");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
