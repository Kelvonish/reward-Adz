import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfServiceWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Terms of Service",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0.0,
              backgroundColor: Colors.white10,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: Stack(
              children: [
                WebView(
                  initialUrl: 'https://rewardads-dev.adalabsafrica.com/terms',
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish) {},
                ),
              ],
            )),
      ),
    );
  }
}
