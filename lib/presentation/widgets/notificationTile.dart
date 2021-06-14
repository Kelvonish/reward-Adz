import 'package:flutter/material.dart';
import 'package:rewardadz/data/models/notificationModel.dart';
import 'package:intl/intl.dart';

class NotificationTile extends StatelessWidget {
  final NotificationData data;
  NotificationTile({this.data});

  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime date) {
      return DateFormat("y MMMM d , h:mm a").format(date);
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                  size: 25,
                )),
            title: Text(
              data.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.description,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.0),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  _formatDate(DateTime.parse(data.createdAt)),
                  style: TextStyle(fontSize: 13.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
