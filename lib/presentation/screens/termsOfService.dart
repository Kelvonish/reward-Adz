import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfServiceWebView extends StatefulWidget {
  @override
  _TermsOfServiceWebViewState createState() => _TermsOfServiceWebViewState();
}

class _TermsOfServiceWebViewState extends State<TermsOfServiceWebView> {
  bool isLoading = true;
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
                  initialUrl: 'https://portal.rewardadz.com/terms',
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                isLoading
                    ? Center(
                        child: SpinKitChasingDots(
                        color: Theme.of(context).primaryColor,
                      ))
                    : Stack(),
              ],
            )),
      ),
    );
  }
}
