import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rewardadz/business_logic/providers/transactionProvider.dart';
import 'package:rewardadz/business_logic/providers/userProvider.dart';
import 'package:rewardadz/presentation/widgets/notificationTile.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).getNotifications(
        Provider.of<UserProvider>(context, listen: false).loggedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Notifications",
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: Container(
            margin: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: Consumer<TransactionProvider>(
                builder: (context, value, child) => Container(
                      child: value.notificationsLoading
                          ? Center(
                              child: SpinKitChasingDots(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : value.notifications == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/notification.png"),
                                    Center(
                                      child: Text(
                                        "No notifications available right now!",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "Check back later.",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          value.notifications.data.length,
                                      itemBuilder: (context, index) {
                                        return NotificationTile(
                                          data: value.notifications.data[index],
                                        );
                                      }),
                                ),
                    )),
          ),
        ),
      ),
    );
  }
}
