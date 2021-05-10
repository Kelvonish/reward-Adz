import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyWebView extends StatefulWidget {
  @override
  _PrivacyPolicyWebViewState createState() => _PrivacyPolicyWebViewState();
}

class _PrivacyPolicyWebViewState extends State<PrivacyPolicyWebView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Privacy Policy",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0.0,
              backgroundColor: Colors.white10,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: Stack(
              children: [
                WebView(
                  gestureNavigationEnabled: true,
                  initialUrl: 'https://rewardads-dev.adalabsafrica.com/privacy',
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish) {},
                ),
              ],
            )),
      ),
    );
  }
}
