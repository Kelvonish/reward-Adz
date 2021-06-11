import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rewardadz/presentation/screens/linkCampaignDetails.dart';

class DynamicLinkService {
  final BuildContext context;
  //final NavigationService _navigationService = locator<NavigationService>();
  DynamicLinkService({this.context});
  Future handleDynamicLinks() async {
    // Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    // Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(onSuccess: (
      PendingDynamicLinkData dynamicLink,
    ) async {
      // handle link that has been retrieved

      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      var isPost = deepLink.pathSegments.contains('campaignDetails');

      if (isPost) {
        var id = deepLink.queryParameters['id'];
        var type = deepLink.queryParameters['type'];
        print(id + " this is where " + type);

        if (id != null) {
          Fluttertoast.showToast(msg: "yeey gotten id");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LinkCampaignDetails(
                        campaignId: id,
                        campaignType: type,
                      )));
        } else {
          Fluttertoast.showToast(msg: "Id is zero");
        }
      } else {
        Fluttertoast.showToast(msg: "Campaign Link not gotten");
      }
    }
  }

  Future createCampaignLink(String id, String type) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://rewardads.page.link',
      link: Uri.parse(
          'https://rewardads.page.link/campaignDetails?id=$id&type=$type'),
      androidParameters: AndroidParameters(
        packageName: 'com.adalabsflutter.rewardadz',
      ),
/*
      // Other things to add as an example. We don't need it now
      iosParameters: IosParameters(
        bundleId: 'com.example.ios',
        minimumVersion: '1.0.1',
        appStoreId: '123456789',
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
        providerToken: '123456',
        campaignToken: 'example-promo',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Example of a Dynamic Link',
        description: 'This link works whether app is installed or not!',
      ),*/
    );

    final Uri dynamicUrl = await parameters.buildUrl();

    return dynamicUrl.toString();
  }
}
