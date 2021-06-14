import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/getCampaignProvider.dart';
import 'package:rewardadz/business_logic/Shared/sortCampaignByType.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Form(
            key: _formKey,
            child: Container(
              height: 40,
              child: TextFormField(
                  validator: (value) =>
                      value.isEmpty ? "Please enter something" : null,
                  textInputAction: TextInputAction.search,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black38,
                      ),
                      hintText: "Search Reward Adz",
                      hintStyle: TextStyle(color: Colors.black45, fontSize: 17),
                      filled: true),
                  onFieldSubmitted: (value) {
                    if (value.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter a text");
                    } else {
                      Provider.of<GetCampaignProvider>(context, listen: false)
                          .searchCampaigns(
                              value,
                              Provider.of<UserProvider>(context, listen: false)
                                  .loggedUser
                                  .token);
                    }
                  }),
            )),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Provider.of<GetCampaignProvider>(context, listen: false)
                      .searchPageInitalState
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(
                              Icons.search,
                              size: 50,
                              color: Colors.black38,
                            ),
                          ),
                          Center(
                              child: Text(
                            "Search for Advertisements",
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.black45),
                          )),
                        ],
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      child: Consumer<GetCampaignProvider>(
                        builder: (context, data, child) => Column(
                          children: [
                            data.searchLoading
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: SpinKitChasingDots(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                : data.searchCampaignList.length == 0
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: Image.asset(
                                                  "assets/empty.png")),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Center(
                                              child: Text(
                                                "No Campaigns match your search!",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            data.searchCampaignList.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return renderCampaignByType(context,
                                              data.searchCampaignList[index]);
                                        }),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
